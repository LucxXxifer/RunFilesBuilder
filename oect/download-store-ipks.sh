#!/bin/sh
set -eu

base_url="${1:-https://repo.istoreos.com/repo/all/store/}"
target_dir="${2:-build/store}"
manifest="${3:-build/source-manifest.tsv}"

mkdir -p "$target_dir" "$(dirname "$manifest")"
: > "$manifest"

index="$(curl -fsSL "$base_url")"

while IFS= read -r package; do
  case "$package" in
    ""|\#*) continue ;;
  esac
  match="$(printf '%s\n' "$index" | grep -o 'href="[^"]*\.ipk"' | sed 's/^href="//; s/"$//' | grep "^${package}_" | sort -V | tail -n 1 || true)"
  if [ -z "$match" ]; then
    echo "ERROR: package not found in store repo: $package" >&2
    exit 20
  fi
  url="${base_url}${match}"
  out="$target_dir/$match"
  curl -fsSL -o "$out" "$url"
  sha="$(sha256sum "$out" | awk '{print $1}')"
  printf '%s\t%s\t%s\n' "$match" "$sha" "$url" >> "$manifest"
done < oect/whitelist.txt
