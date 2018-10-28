%% 这个主程序主要是用于提取微表情特征，基于Facial Micro-Expression 
%  Recognition using Spatiotemporal Local Binary Pattern with Integral 
%  Projection，提出的STLBP-IP方法。

%% read images and extracted features
clear all;close all;clc;
cd ('F:\database\CASME2\Cropped');
a = dir(); %Layer 1
feature_xy = [];
feature_yt = [];
feature_xt = [];
for i = 1 : length(a)
    if (strcmp(a(i).name, '.') == 1)|| (strcmp(a(i).name, '..') == 1)
        continue;
    end
    b = dir (fullfile(a(i).folder,'\',a(i).name)); %Layer 2
    
    for j = 1 : length(b)
        if (strcmp(b(j).name, '.') == 1)|| (strcmp(b(j).name, '..') == 1)
            continue;    
        end
        cd (fullfile(b(j).folder,'\',b(j).name));
        c = dir('*.jpg');
        
        for k = 1 : length(c)
            Imgdat = imread(getfield(c, {k}, 'name'));
            if size(Imgdat, 3) == 3 % if color images, convert it to gray
                Imgdat = rgb2gray(Imgdat); 
            end
            [height, width] = size(Imgdat);
            if k ==1
                VolData = zeros(height, width, length(c));
            end
            VolData(:, :, k) = Imgdat;        
        end
        %% xy平面的特征fxy,调用函数STLBP_IP_XY
        cd ('F:\matlab\2015_STLBP_IP');
        W = 9;
        fxy = STLBP_IP_XY(VolData,W);  %fxy是列向量，256*2位特征
        feature_xy = [feature_xy,fxy];
        %% 水平投影的特征fyt，调用函数STLBP_IP_YT
        fyt = STLBP_IP_YT(VolData)  %fyt是列向量，59维特征
        feature_yt = [feature_yt,fyt];
        %% 垂直投影的特征fxt，调用函数STLBP_IP_XT
        fxt = STLBP_IP_XT(VolData)  %fxt是列向量，59维特征
        feature_xt = [feature_xt,fxt];
    end
      
end
cd ('F:\matlab\2015_STLBP_IP');
save('CASME2_feature_STLBP_IP_XY','feature_xy');
save('CASME2_feature_STLBP_IP_YT','feature_yt');
save('CASME2_feature_STLBP_IP_XT','feature_xt');

feature = [feature_xy;feature_yt;feature_xt];  %512+59+59=630每一个特征都是630维列向量
save('CASME2_feature_STLBP_IP','feature');
