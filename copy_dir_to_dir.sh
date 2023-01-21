#!/bin/bash

###############################################################################
# Purpose: This script is used to search a directory and copy files with a 
# specified extension and a custom file name to a destination directory.
#
# Usage: copy_dir_to_dir.sh [options]
#
# Synopsis: copy_dir_to_dir.sh -s <search_dir> -e <file_ext> -d <destination_dir> -n <file_name>
#
# Arguments:
#   -s, --search      : directory to search
#   -e, --extension   : file extension to search for
#   -d, --destination : directory to copy selected files to
#   -n, --name        : custom file name to copy (search for files containing the provided name)
#   -h, --help        : display this help message
#
# Example:
#   copy_dir_to_dir.sh -s search_dir -e txt -d destination_dir -n custom_file
#
###############################################################################

# Input arguments
search_dir="" # directory to search
file_ext="" # file extension to search for
destination_dir="" # directory to copy selected files to
file_name="" # custom file name to copy

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -s|--search)
            search_dir="$2"
            shift
            shift
            ;;
        -e|--extension)
            file_ext="$2"
            shift
            shift
            ;;
        -d|--destination)
            destination_dir="$2"
            shift
            shift
            ;;
        -n|--name)
            file_name="$2"
            shift
            shift
            ;;
        -h|--help)
            echo "Usage: $0 -s <search_dir> -e <file_ext> -d <destination_dir> -n <file_name>"
            echo "Options:"
            echo "  -s, --search      Directory to search"
            echo "  -e, --extension   File extension to search for"
            echo "  -d, --destination Directory to copy selected files to"
            echo "  -n, --name        Custom file name to copy (search for files containing the provided name)"
            echo "  -h, --help        Display this help message"
            echo ""
            echo "Example:"
            echo "  $0 -s search_dir -e txt -d destination_dir -n custom_file"
            exit 1
            ;;
        *)
            echo "Unknown option: $key"
            echo "Use -h or --help for usage"
            exit 1
            ;;
    esac
done

# Check if search directory exists
if [ ! -d "$search_dir" ]; then
    echo "Search directory does not exist. Exiting script."
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$destination_dir" ]; then
    echo "Destination directory does not exist. Do you want to create it? (y/n)"
    read create_destination
    if [ "$create_destination" == "y" ]; then
        mkdir "$destination_dir"
    else
        echo "Exiting script."
        exit 1
    fi
fi

# Check if the file_ext and custom file name is provided
if [ -z "$file_ext" ] || [ -z "$file_name" ]; then
    echo "File extension or custom file name is not provided. Exiting script."
    exit 1
fi

# Search for files with specified extension and custom file name
files_to_copy=$(find "$search_dir" -name "*$file_name*.$file_ext")

# Count number of files to be copied
num_files=$(echo "$files_to_copy" | wc -l)

# Copy files to destination directory
i=1
for file in $files_to_copy; do
    # Extract the file name
    file_name=$(basename "$file")
    # Check if the file already exists in the destination directory
    if [ ! -f "$destination_dir/$file_name" ]; then
        cp "$file" "$destination_dir"
        # Print progress bar
        echo -ne "Copying files: [$i/$num_files]\r"
        i=$((i+1))
    else
        echo "File $file_name already exists in the destination directory. Skipping copy."
    fi
done

echo -ne "\nCopy completed.\n"

