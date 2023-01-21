#!/bin/bash

# Script Name: install_man_pages.sh
# Purpose: This script installs man pages in the /usr/local/man directory
# and creates a man1 directory for User Commands man pages if it doesn't exist.
# It also gzip the man pages before updating the man page database and request
# sudo privilages.
# Author: Ioannis Polymenis
# Date: 01-01-2022

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  echo "Script Name: install_man_pages.sh"
  echo "Purpose: This script installs man pages in the /usr/local/man directory"
  echo "and creates a man1 directory for User Commands man pages if it doesn't exist."
  echo "It also gzip the man pages before updating the man page database and request"
  echo "sudo privilages."
  echo "Author: Ioannis Polymenis"
  echo "Date: 01-01-2022"
  exit 0
fi

if [ $# -eq 0 ]; then
  echo "Usage: $0 <man_page_1> <man_page_2> ..."
  exit 1
fi

man_dir="/usr/local/man"

if [ ! -d "${man_dir}/man1" ]; then
  sudo mkdir "${man_dir}/man1"
fi

for man_page in "$@"; do
  # Check if the man page file exists
  if [ ! -f $man_page ]; then
    echo "$man_page not found"
    continue
  fi

  # Copy and gzip the man page to the appropriate directory
  section=$(echo $man_page | grep -o '[0-9]')
  sudo cp $man_page ${man_dir}/man${section}/
  sudo gzip -f ${man_dir}/man${section}/$(basename $man_page)
  # update the man page database
  sudo mandb
done

echo "Man pages installed successfully in ${man_dir}."
