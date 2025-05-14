FROM alpine:3.18

# Install required packages
RUN apk add --no-cache sqlite wget

# Install rqlite
RUN wget https://github.com/rqlite/rqlite/releases/download/v7.21.4/rqlite-v7.21.4-linux-amd64.tar.gz && \
    tar xvfz rqlite-v7.21.4-linux-amd64.tar.gz && \
    cp rqlite-v7.21.4-linux-amd64/rqlited /usr/local/bin/ && \
    cp rqlite-v7.21.4-linux-amd64/rqlite /usr/local/bin/ && \
    rm -rf rqlite-v7.21.4-linux-amd64*

# Create directory for database files
RUN mkdir -p /data/db && \
    chmod 777 /data/db

# Set working directory
WORKDIR /data/db

# Expose rqlite ports
EXPOSE 4001 4002

# Start rqlite with proper network configuration
CMD ["rqlited", "-http-addr", "0.0.0.0:4001", "-http-adv-addr", "localhost:4001", "-raft-addr", "0.0.0.0:4002", "-raft-adv-addr", "localhost:4002", "/data/db"]
