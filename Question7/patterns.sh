#!/bin/bash

# Check if file exists
if [ ! -f textfile.txt ]; then
    echo "Error: textfile.txt not found!"
    exit 1
fi

# Convert file to lowercase and split words
words=$(tr '[:upper:]' '[:lower:]' < textfile.txt | tr -s '[:space:]' '\n' | tr -d '[:punct:]')

# Words with only vowels
echo "$words" | grep -E '^[aeiou]+$' > vowels.txt

# Words with only consonants
echo "$words" | grep -E '^[^aeiou]+$' > consonants.txt

# Words with both vowels and consonants, starting with consonant
echo "$words" | grep -E '^[^aeiou]*[aeiou]+.*' > mixed.txt 
