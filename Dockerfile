# Caddy with the DuckDNS DNS provider, so certificates are issued via DNS-01
# (ports 80/443 are blocked upstream, so HTTP-01 / TLS-ALPN-01 cannot work).
FROM caddy:2.11-builder-alpine AS builder
RUN xcaddy build --with github.com/caddy-dns/duckdns

FROM caddy:2.11-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Run unprivileged: port 8444 needs no capability, so strip the file capability
# (otherwise exec fails once every capability is dropped) and own the state dirs.
RUN apk add --no-cache libcap \
	&& setcap -r /usr/bin/caddy \
	&& apk del libcap \
	&& addgroup -S -g 10001 caddy \
	&& adduser -S -D -H -u 10001 -G caddy caddy \
	&& chown -R caddy:caddy /data /config

USER caddy
