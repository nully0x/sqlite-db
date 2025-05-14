FROM alpine:3.18

# Install SQLite and Python/pip for sqlite-web
RUN apk add --no-cache \
    sqlite \
    python3 \
    py3-pip

# Install sqlite-web
RUN pip3 install sqlite-web

# Create directory for database files
RUN mkdir -p /data/db && \
    chmod 777 /data/db

# Set working directory
WORKDIR /data/db

# Volume for database files
VOLUME ["/data/db"]

# Expose port for sqlite-web
EXPOSE 8080

# Start sqlite-web server
CMD ["sqlite_web", "--host", "0.0.0.0", "--port", "8080", "/data/db/database.db"]
