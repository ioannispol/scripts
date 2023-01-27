#!/bin/bash


# This is a bash script that copies a given percentage of files from an input folder to an output   folder. The script takes in three optional arguments: 
# -h: Show help information 
# -i: Input folder path 
# -o: Output folder path 
# -p: Percentage of files to copy (defaults to 100) 

# The script first checks if the input folder exists and if the output folder exists, and creates it if it does not. It then calculates the total number of files in the input folder and calculates the number of files to copy based on the percentage given. Finally, it copies the files from the input folder to the output folder and prints out a confirmation message.


usage() {
    echo "Usage: files_to_copy [-h] -i -o [-b] -p"
    echo "  -h : Show this help"
    echo "  -i : Input folder path"
    echo "  -o : Output folder path"
    echo "  -b : Base folder path (optional)"
    echo "  -p : Percentage of files to copy (0-100)"
}

input_folder=""
output_folder=""
base_dir=""
percentage=0

while getopts 'hi:o:b:p:' option; do
  case "$option" in
    h) usage
       exit
       ;;
    i) input_folder=$OPTARG
       ;;
    o) output_folder=$OPTARG
       ;;
    b) base_dir=$OPTARG
       ;;
    p) percentage=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       usage
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       usage
       exit 1
       ;;
  esac
done

shift $((OPTIND - 1))

# check if percentage is valid number between 0 and 100
if ! [[ "$percentage" =~ ^[0-9]+$ ]] || [ "$percentage" -lt 0 ] || [ "$percentage" -gt 100 ]; then
    echo "Percentage should be a number between 0 and 100"
    exit 1
fi

# check if input folder exists
if [ ! -d "$input_folder" ]; then
    echo "Input folder does not exist"
    exit 1
fi

# check if base_dir folder exists
if [ ! -z "$base_dir" ] && [ ! -d "$base_dir" ]; then
    echo "Base folder does not exist"
    exit 1
fi

# check if output folder exists, if not create it
if [ ! -d "$output_folder" ]; then
    mkdir "$output_folder"
fi

# get total number of files in base_dir or input_folder
if [ ! -z "$base_dir" ]; then
    base_files=$(find "$base_dir" -type f | wc -l)
else
    base_files=$(find "$input_folder" -type f | wc -l)
fi

# calculate number of files to copy based on percentage
files_to_copy=$((base_files * percentage / 100))

# copy files with progress bar
i=0
if [ ! -z "$base_dir" ]; then
    find "$base_dir" -type f | shuf -n $files_to_copy | while read file; do
        filename=$(basename "$file")
        if [ -f "$input_folder"/"$filename" ]; then
            cp "$input_folder"/"$filename" "$output_folder"
            i=$((i+1))
            echo -ne "Copying files: $i/$files_to_copy \r"
        fi
            done
else
    find "$input_folder" -type f | shuf -n $files_to_copy | while read file; do
        cp "$file" "$output_folder"
        i=$((i+1))
        echo -ne "Copying files: $i/$files_to_copy \r"
    done
fi


echo "Copied $files_to_copy files ($percentage%) from $input_folder to $output_folder"
