FROM n8nio/n8n:latest

# Crear usuario y directorio de trabajo
USER root

# Instalar dependencias necesarias
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    cairo-dev \
    jpeg-dev \
    pango-dev \
    musl-dev \
    ttf-dejavu

# Crear directorio para n8n data
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Cambiar al usuario node
USER node

# Variables de entorno por defecto
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/home/node/.n8n/database.sqlite
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=n8n_password_123
ENV GENERIC_TIMEZONE=America/Lima
ENV N8N_METRICS=false
ENV N8N_LOG_LEVEL=info
ENV N8N_LOG_OUTPUT=console

# El puerto debe ser dinámico para Render
ENV PORT=5678

# Exponer el puerto
EXPOSE 5678

# Comando de inicio
CMD ["sh", "-c", "N8N_PORT=$PORT n8n start"]