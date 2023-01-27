"""Rename files in a directory based on the names of the files in a base directory."""
import os
import sys


def rename_files(base_dir: str,
                 files_dir: str,
                 custom_name: str = None) -> None:
    """
    Rename files in a directory based on the names of the files in a base directory.
    
    Parameters:
        base_dir (str): The path to the directory containing the base filenames.
        files_dir (str): The path to the directory containing the files to be renamed.
        custom_name (Optional[str], optional): Custom name to use for renaming the files. If not provided, 
        the base filenames will be used. Defaults to None.
    Returns:
        None
    """

    base_filenames = os.listdir(base_dir)
    files_filenames = os.listdir(files_dir)

    if len(base_filenames) != len(files_filenames):
        print("Error: The number of files in the base directory and files to be renamed directory do not match.")
        sys.exit()

    for i in enumerate(base_filenames):
        base_name = os.path.splitext(base_filenames[i])[0]
        file_extension = os.path.splitext(files_filenames[i])[1]
        if custom_name:
            new_name = custom_name + file_extension
        else:
            new_name = base_name + file_extension
        os.rename(os.path.join(files_dir, files_filenames[i]), os.path.join(
            files_dir, new_name))


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("-b", "--base_dir", required=True,
                        help="The path to the base directory containing the names to use for renaming")
    parser.add_argument("-f", "--files_dir", required=True,
                        help="The path to the directory containing the files to be renamed")
    parser.add_argument("-c", "--custom_name",
                        help="A custom name to use for renaming the files, if this is not provided, the names from the base directory will be used")
    args = parser.parse_args()

    rename_files(args.base_dir, args.files_dir, args.custom_name)
