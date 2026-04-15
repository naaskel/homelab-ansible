#!/usr/bin/env bash
set -u

NTFY_URL="http://ntfy.home/internet"
TARGET="8.8.8.8"
INTERVAL=30
THRESHOLD=3

fails=0
down=0

while true; do
    if ping -c 1 -W 2 "$TARGET" >/dev/null 2>&1; then
        if [ "$down" -eq 1 ]; then
            curl -fsS \
                -H "Title: WIELKI POWRUT INTERNETU" \
                -d "Internet działa z powrotem" \
                "$NTFY_URL" >/dev/null || true
            down=0
        fi
        fails=0
    else
        fails=$((fails + 1))
        if [ "$fails" -ge "$THRESHOLD" ] && [ "$down" -eq 0 ]; then
            curl -fsS \
                -H "Title: INTERNET!" \
                -d "Koniec internetu :(" \
                "$NTFY_URL" >/dev/null || true
            down=1
        fi
    fi
    sleep "$INTERVAL"
done
