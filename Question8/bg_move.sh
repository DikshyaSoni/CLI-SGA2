#!/bin/bash

# Check if directory path is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIR=$1

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory $DIR does not exist."
    exit 1
fi

# Create backup directory inside DIR if it doesn't exist
BACKUP="$DIR/backup"
mkdir -p "$BACKUP"

# Move files in background
for file in "$DIR"/*; do
    # Skip backup directory itself
    [ "$file" == "$BACKUP" ] && continue
    
    mv "$file" "$BACKUP" &
    echo "Moving $(basename "$file") in background with PID: $!"
done

# Wait for all background processes to finish
wait
echo "All files moved to $BACKUP"

