FROM n8nio/n8n:latest

# Cambiar a usuario root para configuraciones
USER root

# Crear directorio para datos con permisos correctos
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chmod 755 /home/node/.n8n

# Variables de entorno
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=MiPassword123
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV GENERIC_TIMEZONE=America/Lima
ENV PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/node/.npm-global/bin"

# Volver al usuario node
USER node

# Verificar que n8n esté instalado y funcione
RUN which node && which npm && ls -la /usr/local/bin/

EXPOSE 5678

# Usar la ruta completa del ejecutable
CMD ["/usr/local/bin/node", "/usr/local/lib/node_modules/n8n/bin/n8n"]
