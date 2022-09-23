#!/bin/bash


if [[ $# != 1  ]]
then
    echo "Usage: bash download_oxf.sh [DATASET_PATH]"
exit 1
fi

dataset_root_folder=$1

make_folder() {
  # Creates a folder and checks if it exists. Exits if folder creation fails.
  local folder=$1
  if [ -d "${folder}" ]; then
    echo "Folder ${folder} already exists. Skipping folder creation."
  else
    echo "Creating folder ${folder}."
    if mkdir -p ${folder}; then
      echo "Successfully created folder ${folder}."
    else
      echo "Failed to create folder ${folder}. Exiting."
      exit 1
    fi
  fi
}

make_folder "${dataset_root_folder}"
cd ${dataset_root_folder}
wget https://www.robots.ox.ac.uk/~vgg/data/oxbuildings/oxbuild_images.tgz
tar -xzvf oxbuild_images.tgz
wget https://www.robots.ox.ac.uk/~vgg/data/oxbuildings/gt_files_170407.tgz
tar -xzvf gt_files_170407.tgz
