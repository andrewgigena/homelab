#!/usr/bin/env fish

if not set -q argv[1]
    echo "Error: Debes especificar un directorio." >&2
    exit 1
end

if not test -d "$argv[1]"
    echo "Error: '$argv[1]' no es un directorio válido." >&2
    exit 2
end

fd -t f --exec echo {} \; --exec nl {} \; . "$argv[1]" | wl-copy
