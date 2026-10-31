#!/bin/sh
# Usage: sh set-domain.sh https://your-real-domain.com   (no trailing slash)
[ -z "$1" ] && echo "Give your domain, e.g. https://example.com" && exit 1
D="$(printf %s "$1" | sed 's#/*$##')"
H="$(printf %s "$D" | sed 's#^https*://##')"
find . -type f \( -name "*.html" -o -name "*.xml" -o -name "*.txt" \) -not -name "set-domain.sh" -exec sed -i.bak -e "s#https://YOUR-DOMAIN.example#$D#g" -e "s#YOUR-DOMAIN.example#$H#g" {} \;
find . -name "*.bak" -delete
echo "Done. Domain set to $D"
