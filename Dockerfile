# Build image
FROM crystallang/crystal:1.4.1-alpine-build as builder
WORKDIR /app
# Cache dependencies
ADD . /app
RUN apk add wget tar gzip
RUN cd /opt && wget https://www.lua.org/ftp/lua-5.4.4.tar.gz && tar xvzf lua-5.4.4.tar.gz && cd lua-5.4.4 && make && make install
RUN shards install --production -v
# Build a binary
RUN shards build --static --no-debug --release --production -v
# ===============
# Result image with one layer
FROM scratch
WORKDIR /
COPY --from=builder /app/bin/scrptlb .
ENTRYPOINT ["/scrptlb"]