#!/bin/bash

# Create a new file named example.txt
echo "Initial content" > example.txt

# Function to generate a random string
generate_random_string() {
    # Using /dev/urandom and base64 for random string generation
    head -c 10 /dev/urandom | base64 | head -c 10
}

# Repeat 20 times
for i in {1..20}
do
    # Generate random content
    random_content=$(generate_random_string)

    # Determine the number of lines in the file
    total_lines=$(wc -l < example.txt)
    total_lines=$((total_lines + 1)) # Increment to avoid division by zero

    # Choose a random line number to insert the content
    line_number=$(($RANDOM % total_lines + 1))

    # Insert the random content into a random location in the file
    sed -i '' "${line_number}i\\
    $random_content" example.txt

    # Add and commit the change
    git add example.txt
    git commit -m "Iteration $i: Updated example.txt"
done
