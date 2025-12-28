#!/usr/bin/env bash
#
# Docker Generator Plugin
# Trigger: post-run
# Creates Docker configuration

function log_plugin() {
    echo "[DOCKER-GENERATOR] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
PROJECT_TYPE="$PF_PROJECT_TYPE"

log_plugin "Generating Docker configuration for $PROJECT_TYPE"

case "$PROJECT_TYPE" in
    python)
        cat <<'EOF' > "$PROJECT_ROOT/Dockerfile"
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "src/main.py"]
EOF
        
        cat <<'EOF' > "$PROJECT_ROOT/docker-compose.yml"
version: '3.8'
services:
  app:
    build: .
    volumes:
      - .:/app
    environment:
      - PYTHONUNBUFFERED=1
EOF
        ;;
    
    nodejs|react)
        cat <<'EOF' > "$PROJECT_ROOT/Dockerfile"
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

CMD ["npm", "start"]
EOF
        
        cat <<'EOF' > "$PROJECT_ROOT/docker-compose.yml"
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
      - /app/node_modules
EOF
        ;;
    
    web)
        cat <<'EOF' > "$PROJECT_ROOT/Dockerfile"
FROM nginx:alpine

COPY src/ /usr/share/nginx/html/
EOF
        
        cat <<'EOF' > "$PROJECT_ROOT/docker-compose.yml"
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80"
EOF
        ;;
esac

# Create .dockerignore
cat <<'EOF' > "$PROJECT_ROOT/.dockerignore"
.git
.env
*.md
logs/
*.log
EOF

log_plugin "Docker configuration created"
echo "Docker configuration generated"
