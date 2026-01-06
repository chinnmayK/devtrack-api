FROM node:18-alpine

# Install nginx & pm2
RUN apk add --no-cache nginx \
 && npm install -g pm2

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install --production

# Copy app source
COPY . .

# Copy nginx config
COPY nginx/default.conf /etc/nginx/http.d/default.conf

# Expose HTTP only
EXPOSE 80

# Start nginx + node (via pm2)
CMD sh -c "pm2 start ecosystem.config.js && nginx -g 'daemon off;'"
