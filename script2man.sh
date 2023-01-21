#!/bin/bash

# Script Name: sh2man.sh
# Purpose: This script parses a .sh file and generates a troff man page
# Author: Ioannis Polymenis
# Date: 01-01-2022

# Function to display usage information
usage() {
  echo "Usage: $0 [-h] [-i <input_file>]"
  echo "  -h      Show this help message"
  echo "  -i      Input file to parse and generate man page for"
}

# Parse command line arguments
while getopts ":hi:" opt; do
  case $opt in
    h)
      usage
      exit 0
      ;;
    i)
      input_file="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      exit 1
      ;;
  esac
done

# Check if input file is specified
if [ -z "$input_file" ]; then
  echo "Error: Input file not specified"
  usage
  exit 1
fi

# Check if the input file exists
if [ ! -f $input_file ]; then
  echo "$input_file not found"
  exit 1
fi

input_name=$(basename $input_file)

# Extract script description
script_desc=$(grep -E '^# Purpose: ' $input_file | cut -c 11-)

# Extract script usage
script_usage=$(grep -E '^# Usage: ' $input_file | cut -c 9-)

# Extract script arguments
script_args=$(grep -E '^# Arguments: ' $input_file | cut -c 13-)

# Create man page
man_file="$input_name.1"

echo ".TH $input_name 1 $(date +"%Y-%m-%d") \"$input_name\" \"User Commands\"" > $man_file
echo ".SH NAME" >> $man_file
echo "$input_name \\- $script_desc" >> $man_file
echo ".SH SYNOPSIS" >> $man_file
echo ".B $input_name" >> $man_file
echo "$script_usage" >> $man_file
echo ".SH DESCRIPTION" >> $man_file
echo "This script $script_desc and takes $script_args as arguments." >> $man_file
echo ".SH OPTIONS" >> $man_file
echo "This script takes $script_args arguments:" >> $man_file
echo "$(grep -E '^# Arguments: ' $input_file | cut -c 13-)" >> $man_file
echo ".SH AUTHOR" >> $man_file
echo "Author's name" >> $man_file
echo ".SH COPYRIGHT" >> $man_file
echo "Copyright information" >> $man_file

echo "Man page $man_file generated successfully."
