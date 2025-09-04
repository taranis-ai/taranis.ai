---
title: "TLS Configuration"
linkTitle: "TLS Configuration"
weight: 6
description: >
  Configure TLS encryption for Taranis AI using Granian ASGI server with SSL certificates and proper environment variables.
---

# TLS Configuration

This guide explains how to configure TLS (Transport Layer Security) for Taranis AI using the Granian ASGI server. TLS provides encrypted communication between clients and the server, essential for secure deployments.

## Key Environment Variables

The primary TLS configuration is handled through Granian environment variables:

```bash
# Update the core API URL to use HTTPS
TARANIS_CORE_URL=https://your-domain.com/api
```

This variable affects multiple components:
- **Frontend service**: Uses `TARANIS_CORE_URL` to communicate with the core API
- **Worker service**: Uses `TARANIS_CORE_URL` for API communication (falls back to `http://{TARANIS_CORE_HOST}{TARANIS_BASE_PATH}api` if not set)
- **GUI service**: Configured via `TARANIS_CORE_API` in config.json

Replace `your-domain.com` with your actual domain name, `localhost`, or a local development domain.for secure communication in Taranis AI
---

This guide explains how to configure TLS (Transport Layer Security) encryption for Taranis AI, specifically focusing on configuring the Granian ASGI server with TLS certificates.

## Quick Start

To get TLS working quickly with self-signed certificates for development:

{{% alert title="Domain Configuration" %}}
Before starting, choose your domain:
- **localhost**: Use `localhost` for simple local development
- **Custom domain**: Use any domain name (e.g., `myapp.local`, `dev.example.com`) and add it to your `/etc/hosts` file: `127.0.0.1 myapp.local`
- **External domain**: Use your actual domain name if accessing from other machines

Replace `your-domain.com` in all examples below with your chosen domain.
{{% /alert %}}

```bash
# 1. Clone Taranis AI repository
git clone https://github.com/taranis-ai/taranis-ai.git
cd taranis-ai

# 2. Generate self-signed certificates for your domain
mkdir -p ./certs

# Create OpenSSL config for modern certificate
# Replace 'your-domain.com' with your actual domain or 'localhost'
cat > ./certs/cert.conf << 'EOF'
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = US
ST = Test
L = Test
O = Taranis-AI-Test
OU = Development
CN = your-domain.com

[v3_req]
keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = your-domain.com
DNS.2 = localhost
IP.1 = 127.0.0.1
EOF

# Generate certificates
openssl genrsa -out ./certs/private_key.pem 2048
openssl req -new -key ./certs/private_key.pem -out ./certs/certificate.csr -config ./certs/cert.conf
openssl x509 -req -in ./certs/certificate.csr -signkey ./certs/private_key.pem \
  -out ./certs/certificate.pem -days 365 -extensions v3_req -extfile ./certs/cert.conf
chmod 644 ./certs/private_key.pem ./certs/certificate.pem

# 3. Configure environment variables
# Replace 'your-domain.com' with your actual domain and ports
cat > .env << 'EOF'
GRANIAN_SSL_CERTIFICATE=/certs/certificate.pem
GRANIAN_SSL_KEYFILE=/certs/private_key.pem
TARANIS_CORE_URL=https://your-domain.com:8443/api
API_KEY=test-secure-api-key
JWT_SECRET_KEY=test-secure-jwt-secret
DB_DATABASE=taranis
DB_USER=taranis
DB_PASSWORD=supersecret
QUEUE_BROKER_USER=taranis
QUEUE_BROKER_PASSWORD=supersecret
EOF

# 4. Start with TLS-enabled Docker Compose
# (Use the complete compose configuration shown below)

# 5. Test TLS connection
curl -k -v https://your-domain.com:8443/
```

**Prerequisites**: 
- Replace `your-domain.com` with your actual domain name
- For local development, you can use `localhost` or set up a local domain in `/etc/hosts`
- For Taranis AI development, you can use `localhost`, `your-domain.com`, or any custom domain that resolves to `127.0.0.1`

## Overview

Taranis AI uses [Granian](https://github.com/emmett-framework/granian) as its ASGI server for the core application. The core service implementation in `/src/core/core/granian.py` configures Granian with `auto_envvar_prefix="GRANIAN"`, which means all Granian configuration options can be set using environment variables with the `GRANIAN_` prefix.

## Environment Variables

### Required TLS Variables

For a basic TLS setup, you need to configure these essential environment variables:

```bash
# SSL Certificate file path
GRANIAN_SSL_CERTIFICATE=/path/to/your/certificate.pem

# SSL Private key file path  
GRANIAN_SSL_KEYFILE=/path/to/your/private_key.pem
```

### Core URL Configuration

When enabling TLS, you must also update the core URL to use HTTPS:

```bash
# Update the core API URL to use HTTPS
TARANIS_CORE_URL=https://your-domain.com/api
```

This variable affects multiple components:
- **Frontend service**: Uses `TARANIS_CORE_URL` to communicate with the core API
- **Worker service**: Uses `TARANIS_CORE_URL` for API communication (falls back to `http://{TARANIS_CORE_HOST}{TARANIS_BASE_PATH}api` if not set)
- **GUI service**: Configured via `TARANIS_CORE_API` in config.json

### Optional TLS Variables

Granian supports additional TLS configuration options through environment variables:

```bash
# SSL Certificate Authority file (optional)
GRANIAN_SSL_CA_CERTS=/path/to/ca-certificates.pem

# SSL Protocol version (optional)
GRANIAN_SSL_MINIMUM_VERSION=TLSv1.2

# Enable SSL certificate verification (optional)
GRANIAN_SSL_VERIFY_MODE=cert_required
```

## Docker Compose Configuration

### Basic TLS Setup

Here's an example Docker Compose configuration with TLS enabled:

```yaml
version: '3.8'

services:
  core:
    image: ghcr.io/taranis-ai/taranis-core:latest
    environment:
      # TLS Configuration
      - GRANIAN_SSL_CERTIFICATE=/certs/certificate.pem
      - GRANIAN_SSL_KEYFILE=/certs/private_key.pem
      
      # Core URL with HTTPS
      - TARANIS_CORE_URL=https://your-domain.com/api
      
      # Database configuration
      - DB_URL=database
      - DB_DATABASE=taranis
      - DB_USER=taranis
      - DB_PASSWORD=supersecret
      
      # Other core settings
      - API_KEY=your-secure-api-key
      - JWT_SECRET_KEY=your-secure-jwt-secret
    volumes:
      - ./certs:/certs:ro
      - core_data:/app/data
    depends_on:
      - database
      - rabbitmq
    ports:
      - "8443:8080"  # HTTPS port mapped to host
    networks:
      - taranis_network
    healthcheck:
      test: ["CMD-SHELL", "/usr/bin/curl --insecure --fail https://localhost:8080/api/health || exit 1"]
      interval: 1m30s
      timeout: 30s
      retries: 5
      start_period: 40s

  worker:
    image: ghcr.io/taranis-ai/taranis-worker:latest
    environment:
      # Core API URL with HTTPS - use host-accessible URL
      - TARANIS_CORE_URL=https://your-domain.com:8443/api
      
      # API Key for communication with core
      - API_KEY=your-secure-api-key
      
      # Disable SSL verification for self-signed certificates
      - SSL_VERIFICATION=False
      
      # Message queue configuration
      - QUEUE_BROKER_HOST=rabbitmq
      - QUEUE_BROKER_USER=taranis
      - QUEUE_BROKER_PASSWORD=supersecret
    depends_on:
      - core
      - rabbitmq
    networks:
      - taranis_network

  gui:
    image: ghcr.io/taranis-ai/taranis-gui:latest
    environment:
      # Core API URL for GUI - use internal Docker networking
      - TARANIS_CORE_API=https://core:8080/api
      
      # nginx upstream configuration (internal communication)
      - TARANIS_CORE_UPSTREAM=core:8080
      - TARANIS_SSE_UPSTREAM=sse:8088
      - TARANIS_FRONTEND_UPSTREAM=frontend:8080
      
      # Base path configuration
      - TARANIS_BASE_PATH=/
      
      # nginx configuration
      - NGINX_WORKERS=4
      - NGINX_CONNECTIONS=16
    depends_on:
      - core
      - sse
    ports:
      - "8080:8080"  # GUI HTTP port (nginx proxy)
    networks:
      - taranis_network

  frontend:
    image: ghcr.io/taranis-ai/taranis-frontend:latest
    environment:
      # Core API URL with HTTPS (internal Docker networking)
      - TARANIS_CORE_URL=https://core:8080/api
      
      # Disable SSL verification for self-signed certificates
      - SSL_VERIFICATION=False
      
      # Base path and host configuration
      - TARANIS_CORE_HOST=https://core:8080
      - TARANIS_BASE_PATH=/
    depends_on:
      - core
    networks:
      - taranis_network

  sse:
    image: ghcr.io/taranis-ai/sse-broker:latest
    environment:
      - SSE_PATH=/sse
    depends_on:
      - core
    networks:
      - taranis_network

  database:
    image: postgres:15
    environment:
      - POSTGRES_DB=taranis
      - POSTGRES_USER=taranis
      - POSTGRES_PASSWORD=supersecret
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - taranis_network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U taranis"]
      interval: 30s
      timeout: 10s
      retries: 5

  rabbitmq:
    image: rabbitmq:3-management
    environment:
      - RABBITMQ_DEFAULT_USER=taranis
      - RABBITMQ_DEFAULT_PASS=supersecret
    networks:
      - taranis_network
    healthcheck:
      test: rabbitmq-diagnostics -q ping
      interval: 30s
      timeout: 30s
      retries: 3

volumes:
  core_data:
  postgres_data:

networks:
  taranis_network:
    driver: bridge
```

### Important Configuration Notes

1. **Port Mapping**: Core service exposes HTTPS on host port 8443 (`8443:8080`)
2. **Internal Communication**: Services use internal Docker hostnames (`core:8080`, `sse:8088`)
3. **SSL Verification**: Disabled for self-signed certificates (`SSL_VERIFICATION=False`)
4. **SSE Service**: Required for GUI functionality - don't forget to include it
5. **Certificate Mounting**: Certificates mounted as read-only (`./certs:/certs:ro`)
6. **Health Checks**: Use `--insecure` flag for self-signed certificate health checks

### Environment File Configuration

You can also use environment files to manage your configuration. Create a `.env` file:

```bash
# .env file for TLS configuration
# TLS Configuration
GRANIAN_SSL_CERTIFICATE=/certs/certificate.pem
GRANIAN_SSL_KEYFILE=/certs/private_key.pem

# Core URL Configuration with HTTPS
TARANIS_CORE_URL=https://your-domain.com:8443/api
TARANIS_CORE_API=https://your-domain.com:8443/api

# Security Keys
API_KEY=your-secure-api-key-replace-in-production
JWT_SECRET_KEY=your-secure-jwt-secret-replace-in-production

# Database Configuration
DB_URL=database
DB_DATABASE=taranis
DB_USER=taranis
DB_PASSWORD=supersecret

# Message Queue Configuration
QUEUE_BROKER_HOST=rabbitmq
QUEUE_BROKER_USER=taranis
QUEUE_BROKER_PASSWORD=supersecret

# SSL Settings for Self-Signed Certificates
SSL_VERIFICATION=False

# Development Settings (optional)
DEBUG=True
COLORED_LOGS=True
```

Then reference it in your Docker Compose file:

```yaml
version: '3.8'

services:
  core:
    image: ghcr.io/taranis-ai/taranis-core:latest
    env_file:
      - .env
    volumes:
      - ./certs:/certs:ro
      - core_data:/app/data
    depends_on:
      - database
    networks:
      - taranis_network
  
  # ... other services with env_file: - .env
```

## Certificate Management

### Generating Self-Signed Certificates

For development and testing purposes, you can generate self-signed certificates. **Important**: Use proper certificate extensions for compatibility with modern TLS implementations.

#### Method 1: Modern Certificate with SAN Extensions (Recommended)

```bash
# Create certificate directory
mkdir -p ./certs

# Create OpenSSL configuration file with proper extensions
cat > ./certs/cert.conf << 'EOF'
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = US
ST = Test
L = Test
O = Taranis-AI-Test
OU = Development
CN = your-domain.com

[v3_req]
keyUsage = keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = your-domain.com
DNS.2 = localhost
IP.1 = 127.0.0.1
EOF

# Generate private key
openssl genrsa -out ./certs/private_key.pem 2048

# Generate certificate signing request using config
openssl req -new -key ./certs/private_key.pem -out ./certs/certificate.csr -config ./certs/cert.conf

# Generate self-signed certificate with extensions (valid for 365 days)
openssl x509 -req -in ./certs/certificate.csr -signkey ./certs/private_key.pem \
  -out ./certs/certificate.pem -days 365 -extensions v3_req -extfile ./certs/cert.conf

# Set appropriate permissions for Docker containers
chmod 644 ./certs/private_key.pem ./certs/certificate.pem
```

**Note**: We use `chmod 644` for both files to ensure Docker containers can read them. In production, use `chmod 600` for the private key and proper user ownership.

#### Method 2: Simple Certificate (Legacy)

```bash
# Create certificate directory
mkdir -p ./certs

# Generate private key
openssl genrsa -out ./certs/private_key.pem 2048

# Generate certificate signing request with hostname
openssl req -new -key ./certs/private_key.pem -out ./certs/certificate.csr \
  -subj "/C=US/ST=Test/L=Test/O=Taranis-AI-Test/OU=Development/CN=your-domain.com"

# Generate self-signed certificate (valid for 365 days)
openssl x509 -req -days 365 -in ./certs/certificate.csr \
  -signkey ./certs/private_key.pem -out ./certs/certificate.pem

# Set appropriate permissions
chmod 644 ./certs/private_key.pem ./certs/certificate.pem
```

#### Verify Certificate

```bash
# Check certificate details
openssl x509 -in ./certs/certificate.pem -text -noout | grep -A 3 "Subject Alternative Name"

# Verify certificate and key match
openssl x509 -noout -modulus -in ./certs/certificate.pem | openssl md5
openssl rsa -noout -modulus -in ./certs/private_key.pem | openssl md5
```

### Using Let's Encrypt Certificates

For production deployments, use Let's Encrypt with Certbot:

```bash
# Install certbot
sudo apt-get install certbot

# Generate certificate
sudo certbot certonly --standalone -d your-domain.com

# Copy certificates to your certs directory
sudo cp /etc/letsencrypt/live/your-domain.com/fullchain.pem ./certs/certificate.pem
sudo cp /etc/letsencrypt/live/your-domain.com/privkey.pem ./certs/private_key.pem

# Set appropriate permissions
sudo chown $(whoami):$(whoami) ./certs/*.pem
chmod 600 ./certs/private_key.pem
chmod 644 ./certs/certificate.pem
```

## Kubernetes Configuration

For Kubernetes deployments, configure TLS using ConfigMaps and Secrets:

```yaml
# TLS Secret
apiVersion: v1
kind: Secret
metadata:
  name: taranis-tls
type: kubernetes.io/tls
data:
  tls.crt: <base64-encoded-certificate>
  tls.key: <base64-encoded-private-key>

---
# Core Deployment with TLS
apiVersion: apps/v1
kind: Deployment
metadata:
  name: taranis-core
spec:
  replicas: 1
  selector:
    matchLabels:
      app: taranis-core
  template:
    metadata:
      labels:
        app: taranis-core
    spec:
      containers:
      - name: core
        image: ghcr.io/taranis-ai/taranis-core:latest
        env:
        - name: GRANIAN_SSL_CERTIFICATE
          value: "/certs/tls.crt"
        - name: GRANIAN_SSL_KEYFILE
          value: "/certs/tls.key"
        - name: TARANIS_CORE_URL
          value: "https://your-domain.com/api"
        - name: API_KEY
          valueFrom:
            secretKeyRef:
              name: taranis-secrets
              key: api-key
        - name: JWT_SECRET_KEY
          valueFrom:
            secretKeyRef:
              name: taranis-secrets
              key: jwt-secret
        volumeMounts:
        - name: tls-certs
          mountPath: /certs
          readOnly: true
      volumes:
      - name: tls-certs
        secret:
          secretName: taranis-tls
```

## Troubleshooting

## Troubleshooting

### Common Issues

**1. Certificate file not found**
```
Error: [SSL: FILE_NOT_FOUND] file not found
```
- Verify certificate paths are correct in environment variables
- Ensure files are mounted properly in Docker containers: `./certs:/certs:ro`
- Check file permissions (certificate: 644, private key: 644 for containers)

**2. Certificate file not readable**
```
Error: Invalid value for '--ssl-keyfile': File '/certs/private_key.pem' is not readable
```
- **Solution**: Set permissions to 644 for Docker containers: `chmod 644 ./certs/private_key.pem`
- **Cause**: Default 600 permissions prevent container processes from reading the key
- **Production**: Use proper user mapping or secrets management instead

**3. SSL handshake failures with certificate version errors**
```
Error: InvalidCertificate(Other(OtherError(UnsupportedCertVersion)))
```
- **Solution**: Generate certificates with proper extensions (Method 1 above)
- **Cause**: Modern TLS implementations require X.509v3 extensions
- **Fix**: Use the OpenSSL configuration file approach with SAN extensions

**4. Core API connection errors**
- Verify `TARANIS_CORE_URL` uses `https://` protocol and correct hostname
- For development with custom domains, ensure they resolve correctly in your `/etc/hosts` file (e.g., `127.0.0.1 your-domain.com`)
- Check that all services are configured with the correct HTTPS URLs
- Validate DNS resolution and network connectivity

**5. GUI/Frontend connection issues**
- Ensure internal service communication uses the correct hostnames
- Check nginx upstream configuration in GUI service
- Verify SSL verification is disabled for self-signed certificates: `SSL_VERIFICATION: "False"`

**6. Worker service cannot connect to Core API**
```
Error: SSL: CERTIFICATE_VERIFY_FAILED
```
- **Solution**: Disable SSL verification for workers with self-signed certificates:
  ```yaml
  worker:
    environment:
      SSL_VERIFICATION: "False"
  ```

### Debugging Commands

```bash
# Test TLS connection manually
curl -k -v https://local.taranis.ai:8443/api/health

# Check certificate details and validity
openssl x509 -in ./certs/certificate.pem -text -noout | grep -E "(Subject|Not After|Subject Alternative Name)" -A 1

# Verify certificate and key match
openssl x509 -noout -modulus -in ./certs/certificate.pem | openssl md5
openssl rsa -noout -modulus -in ./certs/private_key.pem | openssl md5

# Test SSL connection details
openssl s_client -connect local.taranis.ai:8443 -servername local.taranis.ai -showcerts

# Check file permissions
ls -la ./certs/

# Verify DNS resolution
nslookup local.taranis.ai
```

### Container Debugging

```bash
# Check if certificates are properly mounted
docker compose exec core ls -la /certs/

# Test certificate accessibility from inside container
docker compose exec core openssl x509 -in /certs/certificate.pem -noout -subject

# Check Granian process and TLS configuration
docker compose logs core | grep -E "(Starting granian|Listening at|SSL|TLS)"

# Verify environment variables
docker compose exec core env | grep GRANIAN
```

### Logging

Enable debug logging to troubleshoot TLS issues:

```bash
# In your environment or .env file
DEBUG=True
COLORED_LOGS=True
```

Check the Granian and Core service logs for TLS-related errors:

```bash
# Docker Compose
docker-compose logs core

# Kubernetes
kubectl logs deployment/taranis-core
```

## Testing Your TLS Configuration

### Quick TLS Validation Test

After setting up your TLS configuration, validate it works correctly:

```bash
# 1. Test TLS handshake and certificate
curl -k -v https://local.taranis.ai:8443/api/health

# Expected successful output should show:
# * SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
# * Server certificate: ... CN=local.taranis.ai
# * ALPN: server accepted h2 (HTTP/2)
```

### Step-by-Step Test Procedure

1. **Verify Certificate Generation**:
   ```bash
   # Check files exist with correct permissions
   ls -la ./certs/
   # Should show certificate.pem (644) and private_key.pem (644)
   
   # Verify certificate has SAN extensions
   openssl x509 -in ./certs/certificate.pem -text -noout | grep -A 2 "Subject Alternative Name"
   # Should show: DNS:local.taranis.ai, DNS:localhost, IP Address:127.0.0.1
   ```

2. **Test Container Access**:
   ```bash
   # Verify containers can read certificates
   docker compose exec core ls -la /certs/
   docker compose exec core openssl x509 -in /certs/certificate.pem -noout -subject
   ```

3. **Check Service Logs**:
   ```bash
   # Look for successful TLS startup
   docker compose logs core | grep -E "(Starting granian|Listening at)"
   # Should show: [INFO] Listening at: https://0.0.0.0:8080
   
   # Check for worker startup without certificate errors
   docker compose logs core | grep -E "(Started worker|SSL|TLS)"
   ```

4. **Validate TLS Connection**:
   ```bash
   # Test HTTPS connection
   curl -k -I https://local.taranis.ai:8443/
   # Should return HTTP headers with server: granian
   
   # Test with verbose SSL details
   curl -k -v https://local.taranis.ai:8443/ 2>&1 | grep -E "(TLS|SSL|certificate)"
   ```

### Expected Success Indicators

✅ **Successful TLS Setup Shows**:
- Granian logs: `[INFO] Listening at: https://0.0.0.0:8080`
- Workers start without certificate errors: `[INFO] Started worker-1`
- TLS 1.3 connection established: `SSL connection using TLSv1.3`
- HTTP/2 negotiated: `ALPN: server accepted h2`
- Certificate hostname matches: `CN=local.taranis.ai`

❌ **Common Failure Indicators**:
- `InvalidCertificate(UnsupportedCertVersion)` → Use Method 1 certificate generation
- `File not readable` → Fix file permissions with `chmod 644`
- Connection refused → Check port mapping and service status
- Certificate hostname mismatch → Regenerate certificate with correct CN

## Security Considerations

1. **Certificate Management**: Use proper certificate management practices and rotate certificates regularly
2. **Private Key Security**: Protect private keys with appropriate file permissions (600)
3. **Certificate Authority**: Use trusted CAs for production deployments
4. **TLS Version**: Use TLS 1.2 or higher (configure with `GRANIAN_SSL_MINIMUM_VERSION`)
5. **Cipher Suites**: Consider configuring strong cipher suites for enhanced security
6. **HSTS**: Implement HTTP Strict Transport Security headers
7. **Certificate Monitoring**: Monitor certificate expiration and set up automated renewal

## References

- [Granian SSL Configuration](https://github.com/emmett-framework/granian)
- [Docker Compose Environment Variables](https://docs.docker.com/compose/environment-variables/)
- [Let's Encrypt Documentation](https://letsencrypt.org/docs/)
- [OpenSSL Documentation](https://www.openssl.org/docs/)
