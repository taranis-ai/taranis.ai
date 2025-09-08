#!/usr/bin/env bash
# Taranis AI quick installer (Bash, Linux+macOS)
# Usage: curl -fsSL https://taranis.ai/install.sh | bash

set -euo pipefail
trap 'echo -e "${RED:-}!! Error on line $LINENO${NC:-}" >&2; exit 1' ERR

# --- Config ---
REPO="taranis-ai/taranis-ai"
API="https://api.github.com/repos/${REPO}/releases/latest"
COMPOSE_OUT="compose.yml"
ENV_SAMPLE_OUT="env.sample"
ENV_OUT=".env"
TMPDIR="${TMPDIR:-/tmp}"
UMASK_OLD="$(umask)"

# --- Colors (auto) ---
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  BOLD=$'\e[1m'; DIM=$'\e[2m'
  RED=$'\e[31m'; YELLOW=$'\e[33m'; GREEN=$'\e[32m'; CYAN=$'\e[36m'
  NC=$'\e[0m'
else
  BOLD=""; DIM=""; RED=""; YELLOW=""; GREEN=""; CYAN=""; NC=""
fi

info() { printf '%s\n' "${GREEN}==>${NC} $*"; }
note() { printf '%s\n' "${CYAN} ->${NC} $*"; }
warn() { printf '%s\n' "${YELLOW}!!${NC} $*" >&2; }
die()  { printf '%s\n' "${RED}!!${NC} $*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }

cleanup() {
  [[ -n "${TMP_JSON:-}" && -f "${TMP_JSON:-}" ]] && rm -f "$TMP_JSON" || true
  [[ -n "${TMP_ENV:-}"  && -f "${TMP_ENV:-}"  ]] && rm -f "$TMP_ENV"  || true
  umask "$UMASK_OLD" 2>/dev/null || true
}
trap cleanup EXIT INT TERM HUP

# --- Flags / env ---
AUTO_YES=0           # 0 ask, 1 yes, 2 no
AUTO_START=""        # "", "yes", "no"
ADMIN_PW_ENV="${ADMIN_PW:-}"  # optional env override

while (($#)); do
  case "$1" in
    -y|--yes)    AUTO_YES=1 ;;
    -n|--no)     AUTO_YES=2 ;;
    --start)     AUTO_START="yes" ;;
    --no-start)  AUTO_START="no" ;;
    -h|--help)
      cat <<EOF
${BOLD}Taranis AI installer (bash)${NC}

Options:
  -y, --yes          Answer 'yes' to setup prompt
  -n, --no           Answer 'no' to setup prompt
      --start        Start stack after setup
      --no-start     Do not start stack after setup

Env vars:
  GITHUB_TOKEN       Token to avoid GitHub API rate limits
  ADMIN_PW           Admin password for PRE_SEED_PASSWORD_ADMIN (default: "admin" if left blank)
  NO_COLOR=1         Disable color output
EOF
      exit 0
      ;;
    *) die "Unknown option: $1" ;;
  esac
  shift
done

# --- Preflight ---
have curl || die "curl not found. Please install curl."

CURL_OPTS=( -fsSL --retry 3 --retry-delay 2 --retry-connrefused )
CURL_AUTH=()
[[ -n "${GITHUB_TOKEN:-}" ]] && CURL_AUTH=( -H "Authorization: Bearer ${GITHUB_TOKEN}" )

# --- Fetch latest release (simplified exact filenames) ---
info "Fetching latest release metadata for ${REPO}…"
TMP_JSON="$(mktemp "${TMPDIR%/}/taranis-release.XXXXXX")"
curl "${CURL_OPTS[@]}" "${CURL_AUTH[@]}" -H "Accept: application/vnd.github+json" "$API" >"$TMP_JSON"

# Directly grep the JSON for exact asset names (no jq dependency)
COMPOSE_URL="$(grep -Eo 'https://[^"]+/compose\.yml' "$TMP_JSON" | head -n1 || true)"
ENV_SAMPLE_URL="$(grep -Eo 'https://[^"]+/env\.sample' "$TMP_JSON" | head -n1 || true)"

[[ -n "${COMPOSE_URL:-}"    ]] || die "Latest release does not contain compose.yml"
[[ -n "${ENV_SAMPLE_URL:-}" ]] || die "Latest release does not contain env.sample"

note "Compose asset: ${DIM}${COMPOSE_URL}${NC}"
note "env.sample asset: ${DIM}${ENV_SAMPLE_URL}${NC}"

info "Downloading compose -> ./${COMPOSE_OUT}"
curl "${CURL_OPTS[@]}" "$COMPOSE_URL" -o "$COMPOSE_OUT"
info "Downloading env.sample -> ./${ENV_SAMPLE_OUT}"
curl "${CURL_OPTS[@]}" "$ENV_SAMPLE_URL" -o "$ENV_SAMPLE_OUT"

# --- Prompts ---
ask_yes_no() {
  # $1 prompt, $2 default ("yes"|"no")
  local prompt="$1" def="$2" ans
  case "$AUTO_YES" in
    1) printf 'yes\n'; return 0 ;;
    2) printf 'no\n';  return 0 ;;
  esac
  if [[ "$def" == "yes" ]]; then
    read -r -p "$(printf '%s' "$prompt [Y/n] ")" ans || true
  else
    read -r -p "$(printf '%s' "$prompt [y/N] ")" ans || true
  fi
  ans="${ans,,}"
  case "$ans" in
    y|yes) printf 'yes\n' ;;
    n|no)  printf 'no\n' ;;
    *)     printf '%s\n' "$def" ;;
  esac
}

SETUP="$(ask_yes_no "Setup Taranis AI now?" "yes")"
if [[ "$SETUP" == "no" ]]; then
  info "Setup skipped. Files ready: ${BOLD}${COMPOSE_OUT}${NC}, ${BOLD}${ENV_SAMPLE_OUT}${NC}"
  exit 0
fi

# --- Create .env securely ---
umask 077
if [[ -f "$ENV_OUT" ]]; then
  BAK="${ENV_OUT}.bak.$(date +%s)"
  warn "Existing ${ENV_OUT} found. Backing up to ${BAK}"
  cp -f "$ENV_OUT" "$BAK"
fi
cp -f "$ENV_SAMPLE_OUT" "$ENV_OUT"
info "Created ${BOLD}${ENV_OUT}${NC} from ${ENV_SAMPLE_OUT}"

# --- Generate secret & replace all 'supersecret' ---
gen_secret() {
  if have openssl; then
    openssl rand -base64 48 | tr -d '\n'
  elif have dd && have base64; then
    dd if=/dev/urandom bs=48 count=1 2>/dev/null | base64 | tr -d '\n'
  elif have hexdump; then
    hexdump -n 48 -v -e '/1 "%02X"' /dev/urandom 2>/dev/null
  else
    return 1
  fi
}

SECRET="$(gen_secret)" || die "Need openssl OR (dd+base64) OR hexdump to generate a secret."
ESC_SECRET="$(printf '%s' "$SECRET" | sed 's/[&/\]/\\&/g')"

if grep -q 'supersecret' "$ENV_OUT"; then
  TMP_ENV="$(mktemp "${TMPDIR%/}/taranis-env.XXXXXX")"
  sed "s/supersecret/${ESC_SECRET}/g" "$ENV_OUT" >"$TMP_ENV" && mv -f "$TMP_ENV" "$ENV_OUT"
  info "Replaced default secrets in ${BOLD}${ENV_OUT}${NC}"
else
  note "No 'supersecret' token found in ${ENV_OUT}; nothing to replace."
fi

# --- Admin password (env or hidden prompt; default 'admin' on Enter) ---
get_admin_pw() {
  if [[ -n "$ADMIN_PW_ENV" ]]; then
    note "Using admin password from ADMIN_PW env."
    printf '%s\n' "$ADMIN_PW_ENV"
    return 0
  fi
  local pw
  read -r -s -p "Enter admin password for PRE_SEED_PASSWORD_ADMIN (default: admin): " pw || true
  printf '\n'
  [[ -n "$pw" ]] && printf '%s\n' "$pw" || printf 'admin\n'
}

ADMIN_PW_VAL="$(get_admin_pw)"
if [[ "$ADMIN_PW_VAL" == "admin" ]]; then
  warn "Using default admin password 'admin' (you can change it later in ${ENV_OUT})."
fi

ESC_PW="$(printf '%s' "$ADMIN_PW_VAL" | sed 's/[&/\]/\\&/g')"
if grep -q '^PRE_SEED_PASSWORD_ADMIN=' "$ENV_OUT"; then
  TMP_ENV="$(mktemp "${TMPDIR%/}/taranis-env.XXXXXX")"
  sed "s/^PRE_SEED_PASSWORD_ADMIN=.*/PRE_SEED_PASSWORD_ADMIN=${ESC_PW}/" "$ENV_OUT" >"$TMP_ENV" && mv -f "$TMP_ENV" "$ENV_OUT"
else
  printf '\nPRE_SEED_PASSWORD_ADMIN=%s\n' "$ADMIN_PW_VAL" >>"$ENV_OUT"
fi
info "Set ${BOLD}PRE_SEED_PASSWORD_ADMIN${NC} in ${BOLD}${ENV_OUT}${NC}"

# --- Start stack? ---
START="${AUTO_START:-$(ask_yes_no "Start Taranis AI now?" "yes")}"

start_stack() {
  if have podman-compose; then
    info "Starting with ${BOLD}podman-compose${NC}…"
    podman-compose -f "$COMPOSE_OUT" up -d
    return 0
  fi
  if have docker && docker compose version >/dev/null 2>&1; then
    info "Starting with ${BOLD}docker compose${NC}…"
    docker compose -f "$COMPOSE_OUT" up -d
    return 0
  fi
  if have docker-compose; then
    info "Starting with ${BOLD}docker-compose${NC}…"
    docker-compose -f "$COMPOSE_OUT" up -d
    return 0
  fi
  warn "No compose tool found (podman-compose, docker compose, or docker-compose)."
  warn "Install one and start manually, e.g.: ${BOLD}docker compose -f ${COMPOSE_OUT} up -d${NC}"
  return 1
}

if [[ "$START" == "yes" ]]; then
  if start_stack; then
    info "Taranis AI is starting in the background."
  else
    die "Could not start the stack automatically."
  fi
else
  info "Start skipped. You can start later with one of:"
  printf '  %s\n' "podman-compose -f ${COMPOSE_OUT} up -d"
  printf '  %s\n' "docker compose -f ${COMPOSE_OUT} up -d"
  printf '  %s\n' "docker-compose -f ${COMPOSE_OUT} up -d"
fi

# --- Summary ---
printf '\n'
info "${BOLD}All done.${NC}"
note "Files: ${BOLD}${COMPOSE_OUT}${NC}, ${BOLD}${ENV_SAMPLE_OUT}${NC}, ${BOLD}${ENV_OUT}${NC}"
note "Admin user will be pre-seeded with your chosen password."
