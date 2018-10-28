function fxt = STLBP_IP_XT(VolData)
%% 函数是将对齐的人脸图像集得到差分图像，垂直积分投影，得到运动纹理图片
%   利用lbp得到得到纹理的直方图，结果转换为列向量
%   input:
%   VolData ：[height][width][Length] 请注意，所有图像的[height][width]应该相
%   同，但是对于不同序列不一定相同
%   output:
%   fxt:归一化的直方图，列向量

%% 得到差分图像的垂直积分投影的纹理图image_xt
image_xt = [];
[~,~,Length] = size(VolData);
back_image = VolData(:,:,1);
for i = 2:Length
    now_image = VolData(:,:,i);
    diff_image = imsubtract(now_image,back_image); %得到差分图像
    % horizontal Integral projection 垂直积分投影
    h_ip = sum(diff_image); %得到一张差分图像的垂直积分投影向量，行向量
    image_xt = [image_xt;h_ip] %最终得到运动水平积分投影的纹理图
end

%%  得到image_xt的lbp特征，并归一化，转置得到列向量
mapping=getmapping(8,'u2'); 
fxt = lbp(image_xt,1,8,mapping,'h');
fxt = fxt/sum(fxt,2);  %将行向量归一化
fxt = fxt';

