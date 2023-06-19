import torch
import torch.nn as nn
import pandas as pd
import torch.nn.functional as F

import numpy as np

import hand_roscv.process_data as p_data

import hand_roscv.pointnet_model as pm

# 读取训练数据
train_data = pd.read_csv('dataset/new_data.csv')

# 查看最后一列
print(train_data.iloc[:, -1].value_counts())

#随机抽样30%的数据作为测试集
test_data = train_data.sample(frac=0.2)
train_data = train_data.drop(test_data.index)

print(train_data.shape, test_data.shape)


X, y = p_data.data_to_points_cloud(train_data)
Xval, yval = p_data.data_to_points_cloud(test_data)

print(X.shape, y.shape, Xval.shape, yval.shape)

ngpu= 1
# Decide which device we want to run on
device = torch.device("cuda:0" if (torch.cuda.is_available() and ngpu > 0) else "cpu")

X = X.to(device)
y = y.to(device)
Xval = Xval.to(device)
yval = yval.to(device)