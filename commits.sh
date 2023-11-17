#!/bin/bash

# Set locale for tr
LC_ALL=C

# Create a new file named example.txt
echo "Initial content" > example.txt

# Function to generate a random string
generate_random_string() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

# Repeat 20 times
for i in {1..20}
do
    # Generate random content
    random_content=$(generate_random_string 10)

    # Determine the number of lines in the file
    total_lines=$(wc -l < example.txt)
    total_lines=$((total_lines + 1)) # Increment to avoid division by zero

    # Choose a random line number to insert the content
    line_number=$(($RANDOM % total_lines + 1))

    # Insert the random content into a random location in the file
    sed -i "${line_number}i$random_content" example.txt

    # Add and commit the change
    git add example.txt
    git commit -m "Iteration $i: Updated example.txt"
done
