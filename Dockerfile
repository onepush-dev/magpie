# magpie on Railway: the official image (pinned by digest) plus a start wrapper.
# Railway mounts volumes owned by root, while magpie runs as nonroot (uid 65532),
# so the wrapper fixes /config ownership, then drops to 65532 and runs the
# browser UI (which also answers the gateway's /v1 routes) on port 3430.
FROM ghcr.io/yetone/magpie:0.1.2679@sha256:48ed175b9142b09bbddb198e2393edba57794fe7d839cec3da844c90ab01703c
USER root
RUN command -v setpriv >/dev/null
COPY --chmod=755 railway/railway-start.sh /railway-start.sh
ENV MAGPIE_WEB_PORT=3430 \
    MAGPIE_ADDR=0.0.0.0:3425
EXPOSE 3430
ENTRYPOINT ["/railway-start.sh"]
CMD []
