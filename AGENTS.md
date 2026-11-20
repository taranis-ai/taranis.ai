# AGENTS.md

## Workflow

- Do not work directly on `master`; create a feature branch first.
- `/docs/` content lives in `taranis-ai/docs/user` and is imported as a Hugo module; edit it there. Preview a local checkout with `HUGO_MODULE_REPLACEMENTS="github.com/taranis-ai/taranis-ai -> <path>" hugo server`.
- For documentation changes, run `./htmltest.sh`. It builds the Hugo site and runs `htmltest -c .htmltest.yml -s public`.
- Before pushing, commit the completed change, then push with `git push -u origin <branch>`.
- After pushing, run `gh signoff` for the current commit and verify with `gh signoff status`.
- If hooks are needed locally, run `pre-commit run --files <changed-files>`.
