# Proteus static site — served via Nginx
FROM nginx:alpine

# Remove default nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy our site files into nginx's web root
COPY index.html /usr/share/nginx/html/index.html

# Copy custom nginx config (optional but recommended for gzip/caching)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
