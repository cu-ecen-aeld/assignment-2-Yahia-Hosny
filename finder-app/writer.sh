#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

# Extract the arguments
writefile="$1"
writestr="$2"

# Create the directory path if it doesn't exist
dirname="$(dirname "$writefile")"
mkdir -p "$dirname"

# Write the content to the file
echo "$writestr" > "$writefile"

# Check if the file was created successfully
if [ $? -ne 0 ]; then
    echo "Error: Could not create the file '$writefile'."
    exit 1
fi

echo "File '$writefile' created successfully with the content:"
echo "$writestr"

exit 0

