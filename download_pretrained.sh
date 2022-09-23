#!/bin/bash


curl -Os http://storage.googleapis.com/delf/resnet50_imagenet_weights.tar.gz
tar -xzvf resnet50_imagenet_weights.tar.gz

wget https://gitee.com/LinPeijia/delf_-pca/repository/archive/master.zip
unzip master -d .
mv delf_-pca-master/pca .
rm -rf delf_-pca-master/
