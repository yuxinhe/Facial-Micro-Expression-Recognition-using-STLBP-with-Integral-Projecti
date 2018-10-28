function fxy = STLBP_IP_XY(VolData,W)
%% 函数是计算图像集的外观信息，通过调用LBP_1D函数，得到图像集XY面的直方图
%  input:
%  VolData ：[height][width][Length] 请注意，所有图像的[height][width]应该相
%  同，但是对于不同序列不一定相同
%  W: 奇数，一般为3，5，7，9.
%  output:
%  fxy：归一化的直方图

%%
fxy = [];
[~,~,Length] = size(VolData);
back_image = VolData(:,:,1);
for i = 2:Length
    now_image = VolData(:,:,i);
    diff_image = imsubtract(now_image,back_image); %得到差分图像
    % horizontal Integral projection 水平积分投影
    h_ip = sum(diff_image,2); %列向量需要转置
    XVoctor = h_ip';
    Histogram = LBP_1D(XVoctor, W); %水平投影的1DLBP
    h_Histogram = Histogram;
    % vertical Integral projection 垂直积分投影
    v_ip = sum(diff_image);
    XVoctor = v_ip;
    Histogram = LBP_1D(XVoctor, W); %垂直投影的1DLBP
    v_Histogram = Histogram;
    f = [h_Histogram;v_Histogram];
    fxy = [fxy,f];
    fxy = sum(fxy,2)/(Length-1);
end
