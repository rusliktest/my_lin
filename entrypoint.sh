#!/bin/bash -l

echo "======================"
echo "= Linting YAML files ="
echo "======================"

DEFAULT_RULES="{\
    extends: default, \
    rules: {line-length: {max: 120}, \
    document-start: false, \
    truthy: disable}, \
    ignore: /node_modules/}\
"

if [[ -n "$INPUT_CONFIG_FILE" ]]; then
    options+=(-c "$INPUT_CONFIG_FILE")
    
elif [[ -n "$INPUT_CONFIG_DATA" ]]; then
    options+=(-d "$INPUT_CONFIG_DATA")
    
else
    options+=(-d "$DEFAULT_RULES")
fi

options+=(-f "$INPUT_FORMAT")

if [[ "$INPUT_STRICT" == "true" ]]; then
    options+=(-s)
fi

if [[ "$INPUT_NO_WARNINGS" == "true" ]]; then
    options+=(--no-warnings)
fi

# Enable globstar so ** globs recursively
shopt -s globstar
# Use the current directory by default
options+=("${INPUT_FILE_OR_DIR:-.}")
shopt -u globstar

yamllint "${options[@]}"