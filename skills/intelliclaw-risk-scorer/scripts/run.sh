#!/usr/bin/env bash
WS="${1:-.}"
IN="$WS/operations/IntelliClaw/live/normalized-claims.json"
OUT="$WS/operations/IntelliClaw/live/scored-claims.json"
[ ! -f "$IN" ] && echo "[risk-scorer] No input" && exit 1
jq '[.[] | . + {risk: (if .confidence >= 0.8 then "high" elif .confidence >= 0.65 then "medium" else "low" end)}]' "$IN" > "$OUT"
echo "[risk-scorer] Scored $(jq length "$OUT") claims"
