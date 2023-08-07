#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

# Extract the arguments
filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory."
    exit 1
fi

# Function to count the number of matching lines in a file
count_matching_lines() {
    local file="$1"
    local count=0

    while IFS= read -r line; do
        if [[ "$line" == *"$searchstr"* ]]; then
            ((count++))
        fi
    done < "$file"

    echo "$count"
}

# Function to process files in the directory and subdirectories
process_directory() {
    local dir="$1"
    local file_count=0
    local line_count=0

    while IFS= read -r -d '' file; do
        if [ -f "$file" ]; then
            ((file_count++))
            lines_matching=$(count_matching_lines "$file")
            ((line_count += lines_matching))
        fi
    done < <(find "$dir" -type f -print0)

    echo "The number of files are $file_count and the number of matching lines are $line_count"
}

# Call the process_directory function with the provided directory
process_directory "$filesdir"

exit 0

