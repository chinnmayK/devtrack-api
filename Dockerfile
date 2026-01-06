FROM node:18-alpine

# Install nginx & pm2
RUN apk add --no-cache nginx \
 && npm install -g pm2

# Set working directory
WORKDIR /app

# Copy app package files
COPY app/package*.json ./app/
RUN cd app && npm install --production

# Copy rest of the app
COPY app ./app

# Copy nginx config
COPY nginx/default.conf /etc/nginx/http.d/default.conf

# Expose HTTP only (ALB -> Nginx)
EXPOSE 80

# Start nginx + pm2 (CORRECT way for ECS)
CMD sh -c "nginx && pm2-runtime app/ecosystem.config.js"
