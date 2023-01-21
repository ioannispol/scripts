#!/bin/bash

# Script Name: files2folders.sh
# Purpose: This script creates folders based on the names of the files in the current directory, and can also add a prefix to the folder names. 
# Author: Ioannis Polymenis
# Date: 01-01-2022

# Usage: files2folders.sh [-h] [-p <prefix>] [-m | -c | -n]
# Synopsis: files2folders.sh [-h] [-p <prefix>] [-m | -c | -n]
# Arguments:
#   -h      Show this help message
#   -p      Prefix to add to the folder names
#   -m      Move files to their corresponding folders
#   -c      Copy files to their corresponding folders
#   -n      Do not move or copy files, only create folders
# Note: The script will prompt the user for confirmation before creating the folders, and will only operate on files in the current directory, not subdirectories.

# Function to display script usage
usage() {
    echo "Usage: files2folders [-h] [-m | -c | -n] [-p prefix]"
    echo "  -h : Show this help"
    echo "  -m : Move the file"
    echo "  -c : Copy the file"
    echo "  -n : Not move the file"
    echo "  -p : Specify custom prefix"
}

while getopts ":hmcnp:" opt; do
  case $opt in
    m)
      action="m"
      ;;
    c)
      action="c"
      ;;
    n)
      action="n"
      ;;
    h)
      usage
      exit 0
      ;;
    p)
      prefix="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$action" ]; then
    echo "Action option is required, use -h for help"
    exit 1
fi

# Iterate through all files in the current directory
for file in *; do
    # Skip the .sh files
    if [[ $file == *.sh ]]; then
        continue
    fi
    # Get the base name of the file without the file extension
    base_name="${file%.*}"
    folder_name="$prefix_$base_name"
    echo "Folder $folder_name will be created, do you want to continue? (yes/no/custom)"
    read user_input

    if [[ $user_input == "yes" ]]; then
        # Create a directory with the same name as the base name, and add the custom prefix
        mkdir -p "$folder_name"
    elif [[ $user_input == "custom" ]]; then
        echo "Enter custom folder name:"
        read custom_name
        folder_name="$custom_name"
        mkdir -p "$folder_name"
    else
        continue
    fi

    if [[ $action == "m" ]]; then
        # Move the file into the newly created directory
        mv "$file" "$folder_name"
    elif [[ $action == "c" ]]; then
        # Copy the file into the newly created directory
        cp "$file" "$folder_name"
    fi
done

# Log the help message
echo "files2folders [-h] [-m | -c | -n] [-p prefix]" >> log.txt
