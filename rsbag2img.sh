#!/bin/bash


# This script uses the rs-convert tool to convert an input .bag file to depth frames only and extract the images to a specified directory.

# Check if the required argument is provided

if [ -z "$1" ]
then
echo "No argument supplied. Please provide the .bag file as an argument."
exit 1
fi


#Check if the specified file exists

if [ ! -f "$1" ]
then
echo "The specified file does not exist."
exit 1;   # Exit with error status code (non-zero)
fi


Set the output directory for the extracted images. If it doesn't exist, create it.

OUT_DIR="./depth_frames/"   # Default output directory is './depth_frames/' in current working directory. Change this as needed.


if [ ! -d "$OUT_DIR" ]; then   # Create output directory if it doesn't exist already.     mkdir $OUT_DIR; fi


Convert .bag file to depth frames only and extract them to specified output directory using rs-convert tool.     rs-convert $1 --format=png --output=$OUT_DIR --streams=depth     echo "Depth frames extracted successfully!"

Sources:


https://github.com/IntelRealSense/librealsense/issues/3689

https://support.intelrealsense.com/hc/en-us/community/posts/360033198613--bag-file-extraction-and-processing

https://answers.ros.org/question/396822
