#!/bin/bash


if [[ $# -lt 1 || $# -gt 2 ]]
then
    echo "Usage: bash scripts/run_1p_train.sh [TRAIN_STATE] [CHECKPOINT]"
exit 1
fi

if [ "$1" == "tuning" ] || [ "$1" == "attn" ];then
    train_state=$1
else
    echo "train state, it's value must be in [tuning, attn]"
    exit 1
fi

checkpoint=""
if [ $# == 2 ]
then
    checkpoint=$2
fi

cores=`cat /proc/cpuinfo|grep "processor" |wc -l`
echo "the number of logical core" $cores

EXECUTE_PATH=$(pwd)
config_path="${EXECUTE_PATH}/delf_config.yaml"

export DEVICE_ID=0
export RANK_ID=0
export RANK_SIZE=1

echo "Start training for rank 0, device 0"

python train.py \
--config_path=$config_path \
--train_state=$train_state \
--checkpoint_path=$checkpoint > $train_state.log 2>&1 &
