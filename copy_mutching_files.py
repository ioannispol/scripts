import os
import argparse
from shutil import copy2

def copy_matching_files(input_dir:str, 
                        output_dir:str, 
                        base_dir:str) -> None:
    """_summary_
    
    Args:
        input_dir (str): _description_
        output_dir (str): _description_
        base_dir (str): _description_
    """
    
    if not os.path.exists(input_dir):
        print("Input directory does not exist")
        exit(1)
    if not os.path.exists(base_dir):
        print("Base directory does not exist")
        exit(1)
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)
    base_files = [os.path.splitext(file)[0] for file in os.listdir(base_dir)]
    matching_files = []
    for file in os.listdir(input_dir):
        file_name, file_ext = os.path.splitext(file)
        if file_name in base_files:
            matching_files.append((file_name, file_ext))
    for file in matching_files:
        copy2(os.path.join(input_dir, file[0]+file[1]), os.path.join(output_dir, file[0]+file[1]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input_dir', required=True, help='Input directory path')
    parser.add_argument('-o', '--output_dir', required=True, help='Output directory path')
    parser.add_argument('-b', '--base_dir', required=True, help='Base directory path')
    args = parser.parse_args()
    copy_matching_files(args.input_dir, args.output_dir, args.base_dir)
