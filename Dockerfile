# Usar la imagen oficial de n8n
FROM n8nio/n8n:latest

# Cambiar a usuario root para configuraciones
USER root

# Crear directorio para datos de n8n
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Volver al usuario node
USER node

# Variables de entorno
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV DB_TYPE=sqlite
ENV DB_SQLITE_DATABASE=/home/node/.n8n/database.sqlite
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=cambiar_password_123
ENV GENERIC_TIMEZONE=America/Lima
ENV N8N_METRICS=false

# Exponer el puerto (Render usa $PORT automáticamente)
EXPOSE 5678

# Comando de inicio que usa el puerto dinámico de Render
CMD n8n start --tunnel
