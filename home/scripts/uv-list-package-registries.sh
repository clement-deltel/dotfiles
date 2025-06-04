#!/bin/bash
# UV Lock File Parser - Extract package names and registries

set -euo pipefail

LOCK_FILE="${1:-uv.lock}"

if [[ ! -f "$LOCK_FILE" ]]; then
    echo "Error: File '$LOCK_FILE' not found." >&2
    exit 1
fi

# Parse the TOML file using awk and format as table
awk '
BEGIN {
    in_package = 0
    name = ""
    version = ""
    registry = ""
    printf "%-40s %s\n", "Package", "Registry"
    printf "%-40s %s\n", "--------", "--------"
}

# Start of a package block
/^\[\[package\]\]/ {
    if (name != "" && registry != "") {
        printf "%-40s %s\n", name "==" version, registry
    }
    in_package = 1
    name = ""
    version = ""
    registry = ""
    next
}

# End of package block (next package or end of file)
/^\[\[/ && !/^\[\[package\]\]/ {
    if (name != "" && registry != "") {
        printf "%-40s %s\n", name "==" version, registry
    }
    in_package = 0
    next
}

# Extract package name
in_package && /^name = / {
    gsub(/^name = "/, "")
    gsub(/"$/, "")
    name = $0
}

# Extract version
in_package && /^version = / {
    gsub(/^version = "/, "")
    gsub(/"$/, "")
    version = $0
}

# Extract registry from source
in_package && /registry = / {
    match($0, /registry = "([^"]*)"/, arr)
    if (arr[1]) registry = arr[1]
}

END {
    # Print the last package if it exists
    if (name != "" && registry != "") {
        printf "%-40s %s\n", name "==" version, registry
    }
}
' "$LOCK_FILE"
