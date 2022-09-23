#!/bin/bash


# This script downloads the Google Landmarks v2 dataset TRAIN split. To download the dataset
# run the script like in the following example:
#   bash download_gldv2.sh 0 499 [DATASET_PATH]
# 
# The script takes the following parameters, in order:
# - number of image files from the TRAIN split to download (maximum 500)
# - path for dataset

if [[ $# -lt 3 ]]
then
    echo "Usage: bash download_gldv2.sh [BEGIN_IDX] [END_IDX] [DATASET_PATH]"
exit 1
fi

begin_idx=$1
end_idx=$2
dataset_root_folder=$3
split="train"

metadata_url="https://s3.amazonaws.com/google-landmark/metadata"
images_tar_file_base_url="https://s3.amazonaws.com/google-landmark"
images_md5_file_base_url="https://s3.amazonaws.com/google-landmark/md5sum"
mkdir -p ${dataset_root_folder}/${split}

# if csv files have downloaded success, please comment next 7 lines.
csv_train="train.csv train_clean.csv train_attribution.csv train_label_to_category.csv"
for file_name in ${csv_train}; do
  echo "filename $file_name"
  file_url=${metadata_url}/${file_name}
  echo "Download $file_url to ${dataset_root_folder}/${split}/${file_name} ..."
  wget ${file_url} -t 10 -O ${dataset_root_folder}/${split}/${file_name}
done

for i in $(seq ${begin_idx} 1 ${end_idx}); do
  idx=`printf "%03g" $i`
  images_md5_file=md5.images_${idx}.txt
  images_tar_file=images_${idx}.tar
  images_tar_file_url=${images_tar_file_base_url}/${split}/${images_tar_file}
  images_md5_file_url=${images_md5_file_base_url}/${split}/${images_md5_file}

  echo "Download ${images_tar_file_url} to ${dataset_root_folder}/${split}/${images_tar_file} ..."
  wget ${images_tar_file_url} -t 10 -O ${dataset_root_folder}/${split}/${images_tar_file}
  echo "Download ${images_md5_file} to ${dataset_root_folder}/${split}/${images_md5_file} ..."
  wget ${images_md5_file_url} -t 10 -O ${dataset_root_folder}/${split}/${images_md5_file}
done