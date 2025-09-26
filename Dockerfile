# Usar imagen base de Node.js 20 Alpine (compatible con n8n)
FROM node:20-alpine

# Instalar dependencias del sistema necesarias para n8n
RUN apk add --no-cache \
    python3 \
    py3-pip \
    make \
    g++ \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    musl-dev \
    git \
    bash

# Crear usuario node (ya existe en la imagen base)
USER root

# Instalar n8n globalmente
RUN npm install -g n8n@latest --unsafe-perm

# Cambiar al usuario node
USER node

# Crear directorio de trabajo
WORKDIR /home/node

# Crear directorio para datos de n8n
RUN mkdir -p /home/node/.n8n

# Variables de entorno
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=MiPassword123
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV GENERIC_TIMEZONE=America/Lima
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/home/node/.n8n/database.sqlite

# Exponer puerto
EXPOSE 5678

# Verificar que n8n se instaló correctamente
RUN which n8n && n8n --version

# Comando de inicio
CMD ["n8n", "start"]
