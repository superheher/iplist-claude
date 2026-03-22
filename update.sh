#!/bin/bash
# Fetch Claude API IP ranges from Anthropic documentation.
# Outputs IPv4 CIDR ranges to lists/cidr4.txt

set -euo pipefail

URL="https://platform.claude.com/docs/en/api/ip-addresses"
OUTPUT="lists/cidr4.txt"

mkdir -p lists

curl -sf "$URL" \
    | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+' \
    | sort -u \
    > "$OUTPUT.tmp"

# Remove phased-out addresses (34.162.x.x range).
grep -v '^34\.162\.' "$OUTPUT.tmp" > "$OUTPUT" || true
rm -f "$OUTPUT.tmp"

echo "Updated $OUTPUT with $(wc -l < "$OUTPUT" | tr -d ' ') entries."
