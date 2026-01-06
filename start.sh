#!/bin/sh

# Start Node.js app in background using PM2
npx pm2 start index.js --name devtrack-api --no-daemon &

# Start nginx in foreground
nginx -g 'daemon off;'
