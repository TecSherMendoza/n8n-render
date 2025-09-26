# Usar la imagen oficial de n8n
FROM n8nio/n8n:latest

# Cambiar a usuario root para configuraciones
USER root

# Crear directorio para datos de n8n con permisos correctos
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod 700 /home/node/.n8n

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
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Exponer el puerto
EXPOSE 5678

# Comando de inicio directo (sin shell)
CMD ["n8n", "start"]
