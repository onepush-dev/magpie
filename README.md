# magpie on Railway: one AI gateway for Claude Code, Codex, Gemini CLI, OpenCode and more

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/PLACEHOLDER)

[magpie](https://github.com/yetone/magpie) (MIT, by yetone) puts every coding agent behind one gateway: any model for any agent, API keys or the subscriptions you already pay for (Claude, ChatGPT, Copilot, Gemini, Grok), failover between accounts, routing groups, usage and quota tracking. This template runs magpie's documented server mode: the browser UI (gateway mode) on one HTTPS Railway domain, which also answers the gateway's `/v1` routes, so your agents on any computer can use it.

Image: `ghcr.io/onepush-dev/magpie:0.1.2679` = official `ghcr.io/yetone/magpie:0.1.2679` (pinned by digest) + a small Railway start wrapper.

## Features
- Browser UI: Providers, Gateway (gateway keys with limits), Routing groups, Usage, Plugins, Settings
- OpenAI-, Anthropic- and Gemini-compatible endpoints at `https://<your-domain>/v1` (and `/`)
- Subscription sign-ins and provider keys kept on a persistent volume (`/config`)
- Zero inputs: the page key `MAGPIE_WEB_KEY` is generated per deploy

## Open the UI
1. In Railway, copy `MAGPIE_WEB_KEY` from the magpie service's Variables.
2. Open `https://<your-domain>/?k=<MAGPIE_WEB_KEY>`. The key is traded for a cookie (400 days) and removed from the address. Without it the page asks for the key.
3. Providers → Add provider (paste an API key, or sign in to a subscription; for a sign-in, paste the `localhost` callback address the vendor sends you back to into the Callback URL field).
4. Gateway → Gateway keys → add one key per client.

## Point an agent at it
Use a gateway key as the API key and `https://<your-domain>/v1` as the base URL for OpenAI clients (`https://<your-domain>` for Anthropic/Gemini clients). Model ids are `provider/model` or a routing group; `GET /v1/models` lists them. Requests without an enabled gateway key get 401.

## Notes
- Anyone with `MAGPIE_WEB_KEY` can change magpie and see its keys: keep it secret, rotate it by changing the variable.
- Optional variables: `MAGPIE_ALLOW_IPS` (restrict client IPs; behind Railway's proxy every request comes from the proxy, so usually leave unset), `DO_NOT_TRACK=1` (turn off magpie's anonymous daily usage ping), `DISABLE_AUTOUPDATER=1` (hold the Claude Code build magpie downloads).
- The wrapper fixes `/config` ownership for uid 65532 and runs `magpie web --addr 0.0.0.0:$PORT --no-open`.
- Update by bumping the image tag; data stays on the volume.

## License
magpie is MIT-licensed by yetone. magpie is not affiliated with Apache Magpie. This repo only holds Railway packaging (MIT).
