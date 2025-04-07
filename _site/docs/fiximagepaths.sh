#!/bin/bash

echo "Fixing asset paths in _layouts/*.html..."

for file in _layouts/*.html; do
  echo "Updating $file"

  # Replace src="/assets/... → src="{{ '/assets/... | relative_url }}"
  sed -i.bak -E 's|src="/assets/([^"]+)"|src="{{ \x27/assets/\1\x27 | relative_url }}"|g' "$file"

  # Replace href="/assets/... → href="{{ '/assets/... | relative_url }}"
  sed -i.bak -E 's|href="/assets/([^"]+)"|href="{{ \x27/assets/\1\x27 | relative_url }}"|g' "$file"

  # Replace url(/assets/...) in inline CSS or <style> blocks
  sed -i.bak -E 's|url\(/assets/([^)\x27\x22]+)\)|url({{ \x27/assets/\1\x27 | relative_url }})|g' "$file"

  # Remove backup files
  rm "$file.bak"
done

echo "✅ Done! All asset paths now use relative_url."
