#!/bin/bash


if [[ $# != 1  ]]
then
    echo "Usage: bash download_paris.sh [DATASET_PATH]"
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
wget https://www.robots.ox.ac.uk/~vgg/data/parisbuildings/paris_1.tgz
wget https://www.robots.ox.ac.uk/~vgg/data/parisbuildings/paris_2.tgz
wget https://www.robots.ox.ac.uk/~vgg/data/parisbuildings/corrupt.txt
tar -xzvf paris_1.tgz
tar -xzvf paris_2.tgz
cd paris
while read line || [[ -n ${line} ]]
do
  echo "Delete corrupt image $line"
  rm -f $line
done < ../corrupt.txt
cd ..
mkdir paris6k_images
mv paris/*/*.jpg paris6k_images/
rm -rf paris
wget https://www.robots.ox.ac.uk/~vgg/data/parisbuildings/paris_120310.tgz
tar -xzvf paris_120310.tgz
