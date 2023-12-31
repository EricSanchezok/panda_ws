import torch
import torch.nn as nn
import pandas as pd
import torch.nn.functional as F

import numpy as np

import hand_roscv.process_data as p_data
import hand_roscv.pointnet_model as pm
import hand_roscv.visualization as vs

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


model = pm.get_model(num_classes=11, global_feat=True, feature_transform=False, channel=3)

model.cuda(device=device)

# 定义损失函数和优化器
loss = nn.MSELoss()
optimizer = torch.optim.Adam(model.parameters(),lr = 0.00004)


num_epochs = 15
num_samples = X.shape[0]
batch_size = 32



for epoch in range(num_epochs):
    train_loss = 0.0
    for i in range(0, num_samples, batch_size):
        input = X[i:i+batch_size]
        label = y[i:i+batch_size]
 
        # 前向传播
        model.train()
        output, trans, trans_feat = model(input)

        l = loss(output, label)
        
        # 反向传播和优化
        optimizer.zero_grad()
        l.backward()
        optimizer.step()

        train_loss += l.item()

    train_loss /= num_samples
    with torch.no_grad():
        model.eval()
        y_pred, _, _ = model(Xval)
        val_loss = loss(y_pred, yval).item()

    value = []
    value.append(train_loss)
    value.append(val_loss)
    vs2Dvalue.draw_2Dvalue(value)


    # 打印每个 epoch 的损失
    print(f'Epoch {epoch+1}/{num_epochs}, train_Loss: {train_loss}, val_Loss: {val_loss}')
    
    if val_loss < 0.0001:
        break
    


    # 保存模型
torch.save(model.state_dict(), 'model/model.pth')