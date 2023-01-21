# Scripts for Automating Everyday Tasks
## Introduction
In this repository, you will find a collection of bash scripts that can be used to automate everyday tasks and make life easier for Linux users and developers. The scripts included in this repository are:

create_folders_from_files: This script takes a list of files as input and creates a new folder for each file, with the name of the folder being the same as the name of the file. The script also includes options to move, copy, or not move the files to the new folders.

sh2man.sh: This script takes a .sh file as input and generates a troff man page for the script.

install_man_pages.sh: This script takes a man page file as input and installs it in the /usr/local/man directory.

## Usage
To use the create_folders_from_files script, navigate to the script directory and run the script with the following command:

```bash
./create_folders_from_files.sh -f file1 file2 file3
```
To use the sh2man.sh script, navigate to the script directory and run the script with the following command:

```bash
./sh2man.sh scriptname.sh
```
To use the install_man_pages.sh script, navigate to the script directory and run the script with the following command:

```
sudo ./install_man_pages.sh scriptname.1.gz
```

### To install the scripts in the above repository, you can follow these steps:

1. Clone the repository to your local machine using the command git clone https://github.com/<username>/automation-scripts.git
2. Navigate to the directory where the repository has been cloned using the command cd automation-scripts
3. Make the scripts executable using the command chmod +x create_folders_from_files.sh sh2man.sh install_man_pages.sh
4. Run the install_man_pages.sh script using the command sudo ./install_man_pages.sh scriptname.1.gz
5. For the create_folders_from_files and sh2man.sh scripts, you can move them to a location in your PATH so that you can run them from any directory.
6. Alternatively, you can create symlinks to the scripts in a directory that is already in your PATH.
7. To use the create_folders_from_files script, navigate to the script directory and run the script with the following command:

```
./create_folders_from_files.sh -f file1 file2 file3
```
8. To use the sh2man.sh script, navigate to the script directory and run the script with the following command:

```
./sh2man.sh scriptname.sh
```
> After following these steps, you should be able to run the scripts from anywhere on your system, and the man pages should be installed and accessible via the man command.

## Benefits
These scripts can be very useful for developers who want to document their scripts and make them easily accessible to other users. They can also be improved by adding more options, such as the ability to specify the output directory for the man pages, or by adding error handling for invalid input.

## Conclusion
Overall, these scripts are a great example of how bash scripting can be used to automate and streamline everyday tasks, making life easier for Linux users and developers alike. Additionally, you can use the sh2man.sh and install_man_pages.sh scripts together to generate and install man pages for your scripts in a simple and efficient way. This will make it much easier for other users to understand and use your scripts, and will improve the overall experience for everyone.

Author and date:

Ioannis Polymenis, 2022
