%% 使用SVM作为分类器，留一法选取训练测试集
clear all;close all;clc;
%  准备数据，并规范数据格式，libsvm中label，m个样本就是m*1,列向量；
%  feature,m个样本，n维特征，m*n
clear all;close all;clc;
load 'CASME2_feature_STLBP_IP_YT.mat';
load 'CASME2_label.mat';
feature_yt = feature_yt';
N = length(label);  %N为label长度
rate = 0;
for i = 1:N
    [train,test] = crossvalind('LeaveMOut',N,1);%留一法
    %训练集
    train_feature = feature_yt(train,:)
    train_label = label(train);
    %测试集
    test_feature = feature_yt(test,:)
    test_label = label(test);
    %svm模型
    model = svmtrain(train_label,train_feature);
    %验证结果
    [predicted_label, accuracy, prob_estimates] = svmpredict(test_label, test_feature, model, 'b');
    rate = rate + accuracy(1);
end

%%计算识别率
rate = rate/(N*100)