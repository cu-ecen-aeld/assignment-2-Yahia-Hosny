#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Error: Two arguments are required - filesdir and searchstr"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check if filesdir exists and is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory"
    exit 1
fi

# Count the number of files and matching lines
file_count=0
matching_lines=0

# Recursive function to process directories and count matching lines
process_directory() {
    local dir="$1"
    local files=("$dir"/*)
    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            file_count=$((file_count + 1))
            count=$(grep -c "$searchstr" "$file")
            matching_lines=$((matching_lines + count))
        elif [ -d "$file" ]; then
            process_directory "$file"
        fi
    done
}

process_directory "$filesdir"

# Print results
echo "The number of files are $file_count and the number of matching lines are $matching_lines"

