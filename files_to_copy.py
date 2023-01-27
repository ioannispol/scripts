import os
import argparse
import random

def files_to_copy(input_folder, output_folder, percentage, base_dir):
    # check if percentage is valid number between 0 and 100
    if percentage < 0 or percentage > 100:
        print("Percentage should be a number between 0 and 100")
        exit(1)
    # check if input folder exists
    if not os.path.exists(input_folder):
        print("Input folder does not exist")
        exit(1)
    # check if output folder exists, if not create it
    if not os.path.exists(output_folder):
        os.mkdir(output_folder)
    # check if base folder exists
    if base_dir:
        if not os.path.exists(base_dir):
            print("Base folder does not exist")
            exit(1)
        base_files = os.listdir(base_dir)
    # get total number of files in input_folder
    input_files = os.listdir(input_folder)
    if base_dir:
        input_files = [file for file in input_files if file in base_files]
    # calculate number of files to copy based on percentage
    files_to_copy = len(input_files) * (percentage / 100)
    files_to_copy = int(files_to_copy)
    # copy files
    random.shuffle(input_files)
    i = 0
    for file in input_files[:files_to_copy]:
        os.system(f'cp {os.path.join(input_folder, file)} {output_folder}')
        i += 1
        print(f'Copying files: {i}/{files_to_copy}', end='\r')
    print("Copying files: Done!")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', required=True, help='Input folder path')
    parser.add_argument('-o', '--output', required=True, help='Output folder path')
    parser.add_argument('-p', '--percentage', type=int, default=100, help='Percentage of files to copy (0-100)')
    parser.add_argument('-b', '--base_dir', help='Base folder path')
    args = parser.parse_args()
    files_to_copy(args.input, args.output, args.percentage, args.base_dir)
