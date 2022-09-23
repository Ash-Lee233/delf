# DELF

implementation of an attentive local feature descriptor suitable for large-scale image retrieval, referred to as DELF (DEep Local Feature).
[Paper](https://arxiv.org/abs/1612.06321)：Noh, H. , et al. "Large-Scale Image Retrieval with Attentive Deep Local Features." *2017 IEEE International Conference on Computer Vision (ICCV)* IEEE, 2017.

# Dataset

train: [Google Landmarks Dataset v2](https://arxiv.org/abs/2004.01804)

eval: 

1. [Oxford5k](https://www.robots.ox.ac.uk/~vgg/data/oxbuildings/)


2. [Paris6k](https://www.robots.ox.ac.uk/~vgg/data/parisbuildings/)

# Prepare
```shell
bash download_gldv2.sh [START_IDX] [END_IDX] [DATASET_PATH]

cd [DATASET_PATH]/train
tar xvf images_xxx.tar # 000, 001, 002, 003, ...

python build_image_dataset.py \
--train_csv_path=[DATASET_PATH]/train/train.csv \
--train_clean_csv_path=[DATASET_PATH]/train/train_clean.csv \
--train_directory=[DATASET_PATH]/train/*/*/*/ \
--output_directory=[DATASET_PATH]/mindrecord/ \
--num_shards=128 \
--validation_split_size=0.2

bash download_oxf.sh [DATASET_PATH]
bash download_paris.sh [DATASET_PATH]

bash download_pretrained.sh
```

# Train

```python
traindata_path: "/home/gldv2/mindrecord/train.mindrecord000"
imagenet_checkpoint: "/home/delf/resnet50_weights_tf_dim_ordering_tf_kernels_notop.h5"
bash run_1p_train.sh tuning
OR
bash run_1p_train.sh attn [CHECKPOINT]
```

# Eval

```python
bash scripts/run_eval_match_images.sh [IMAGES_PATH] [CHECKPOINT] [DEVICES]
# example: bash scripts/run_eval_match_images.sh /home/oxford5k_images/ /home/delf/ckpt/checkpoint_delf_attn-1_4989.ckpt 0

OR

bash scripts/run_eval_retrieval_images.sh [IMAGES_PATH] [GT_PATH] [CHECKPOINT] [DEVICES]
# example: bash scripts/run_eval_retrieval_images.sh /home/paris_images/ /home/paris_120310/ /home/delf/ckpt/checkpoint_delf_attn-1_4989.ckpt 01
```

```log
# cat mAP.txt
easy
mAP=91.85
mP@k[10 20 30 40 50 60 70 80 90] [91.07 83.47 78.89 74.85 71.79 69.44 67.51 65.84 64.65]
mR@k[10 20 30 40 50 60 70 80 90] [61.07 75.89 83.06 86.52 89.47 91.94 93.47 94.39 95.32]
hard
mAP=70.48
mP@k[10 20 30 40 50 60 70 80 90] [78.18 67.34 60.84 56.26 52.63 49.89 47.63 45.85 44.29]
mR@k[10 20 30 40 50 60 70 80 90] [46.36 59.41 66.55 71.33 74.33 76.97 79.62 81.93 82.98]
medium
mAP=82.09
mP@k[10 20 30 40 50 60 70 80 90] [89.36 84.21 78.45 74.3  70.04 66.04 62.77 59.81 57.25]
mR@k[10 20 30 40 50 60 70 80 90] [40.62 55.01 63.5  69.98 74.58 77.81 80.85 82.99 84.58]
```





