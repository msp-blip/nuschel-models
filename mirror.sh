#!/usr/bin/env bash
# Copies the models listed in models.json to this repository's release "models-v1", the fallback source Nuschel
# uses when a company network blocks the first one. Every file is fetched from its pinned source and must match
# its SHA-256 before anything is uploaded. GitHub takes at most 2 GB per file, so larger files go up in parts
# (<file>.part1, <file>.part2, … of 1.9 GB); Nuschel joins them and checks the same SHA-256 again.
# At the end every file is downloaded back from the public address and checked, as Nuschel will fetch it.
set -euo pipefail
PART=1900000000
TAG=models-v1
BASE="https://github.com/${GITHUB_REPOSITORY}/releases/download/${TAG}"

gh release view "$TAG" >/dev/null 2>&1 || gh release create "$TAG" --title "Nuschel models v1" --notes-file NOTICE.md
existing=$(gh release view "$TAG" --json assets --jq '.assets[] | "\(.name) \(.size)"')

jq -c '.[]' models.json | while read -r m; do
  file=$(jq -r .file <<<"$m"); url=$(jq -r .url <<<"$m"); sha=$(jq -r .sha256 <<<"$m"); size=$(jq -r .size <<<"$m")
  if [ "$size" -le "$PART" ]; then names=("$file"); else
    count=$(( (size + PART - 1) / PART )); names=(); for i in $(seq 1 "$count"); do names+=("$file.part$i"); done
  fi
  missing=0
  for n in "${names[@]}"; do grep -q "^$n " <<<"$existing" || missing=1; done
  if [ "$missing" = 1 ]; then
    curl -fsSL --retry 3 -o "$file" "$url"
    echo "$sha  $file" | sha256sum -c -
    if [ "$size" -gt "$PART" ]; then split -b "$PART" -a 1 --numeric-suffixes=1 "$file" "$file.part"; fi
    for n in "${names[@]}"; do gh release upload "$TAG" "$n" --clobber; echo "$n uploaded"; done
    rm -f "$file" "$file".part*
  else
    echo "$file already there"
  fi
  # Check from outside, exactly as the app fetches: the public addresses, joined, against the pinned SHA-256.
  got=$(for n in "${names[@]}"; do curl -fsSL --retry 3 "$BASE/$n"; done | sha256sum | cut -d' ' -f1)
  [ "$got" = "$sha" ] || { echo "$file: public copy has $got, expected $sha"; exit 1; }
  echo "$file verified from $BASE"
done
