FROM node:18-alpine

# Install nginx
RUN apk add --no-cache nginx

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install production dependencies
RUN npm install --production

# Copy application code
COPY . .

# Create nginx runtime directory
RUN mkdir -p /run/nginx

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose only nginx port
EXPOSE 80

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start both services
CMD ["/start.sh"]
