function fyt = STLBP_IP_YT(VolData)
%% 函数是将对齐的人脸图像集得到差分图像，水平积分投影，得到运动纹理图片
%   利用lbp得到得到纹理的直方图，结果转换为列向量
%   input:
%   VolData ：[height][width][Length] 请注意，所有图像的[height][width]应该相
%   同，但是对于不同序列不一定相同
%   output:
%   fyt:归一化的直方图，列向量

%% 得到差分图像的水平积分投影的纹理图image_yt
image_yt = [];
[~,~,Length] = size(VolData);
back_image = VolData(:,:,1);
for i = 2:Length
    now_image = VolData(:,:,i);
    diff_image = imsubtract(now_image,back_image); %得到差分图像
    % horizontal Integral projection 水平积分投影
    h_ip = sum(diff_image,2); %得到一张差分图像的水平积分投影向量，列向量
    image_yt = [image_yt,h_ip] %最终得到运动水平积分投影的纹理图
end

%%  得到image_yt的lbp特征，并归一化，转置得到列向量
mapping=getmapping(8,'u2'); 
fyt = lbp(image_yt,1,8,mapping,'h');
fyt = fyt/sum(fyt,2);  %将行向量归一化
fyt = fyt';

