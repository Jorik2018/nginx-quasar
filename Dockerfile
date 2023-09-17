# Use the official Nginx image as the base image
FROM nginx:latest

# Copy your Nginx configuration file to the appropriate location
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy your app build files to the Nginx web root
COPY dist/spa /var/www/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx when the container is run
CMD ["nginx", "-g", "daemon off;"]
