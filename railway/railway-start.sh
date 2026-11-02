#!/bin/sh
# Railway start wrapper for magpie (browser UI + gateway on one port).
set -e
PORT="${PORT:-3430}"
mkdir -p /config/home /config/cache /config/data /config/state /config/magpie
# Railway volumes start root-owned; magpie runs as nonroot (uid 65532).
if [ "$(id -u)" = "0" ]; then
  chown -R 65532:65532 /config 2>/dev/null || true
  RUN="setpriv --reuid=65532 --regid=65532 --clear-groups --"
else
  RUN=""
fi
if [ -n "$MAGPIE_WEB_KEY" ]; then
  echo "magpie: browser UI key is set (MAGPIE_WEB_KEY). Open https://${RAILWAY_PUBLIC_DOMAIN:-<your-domain>}/?k=<MAGPIE_WEB_KEY>"
fi
exec $RUN /magpie web --addr "0.0.0.0:${PORT}" --no-open "$@"
