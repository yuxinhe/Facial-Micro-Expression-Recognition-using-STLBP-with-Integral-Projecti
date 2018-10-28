function Histogram = LBP_1D(XVoctor, W)
% This function is used to calculate one dimensional LBP characteristics 
% and returns histogram of a voctor.
% 'XVoctor' it's a row vector 行向量
% 'W' is a linear mask,  an odd number ensuring the symmetric neighborhood 
% of each element W 是奇数，一般是3，5，7，9.
% m is neighbor, m = W -1.
% Histogram 输出是一个归一化的列向量
m = W-1;
r = (W-1)/2;
l = length(XVoctor);
Histogram = zeros(2^m,1);
for i = (1+r):(l-r)
    %得到中心点i的邻居
    s = [];
    for j = (i-r):(i-1)
        if XVoctor(j) >= XVoctor(i)
            n = 1;
        else
            n =0;
        end
        s = [s,n];
    end
    for j = (i+1):(i+r)
        if XVoctor(j) >= XVoctor(i)
            n = 1;
        else
            n =0;
        end
        s = [s,n];
    end
    %计算中心点的lbp值
    sum = 0;
    len = length(s);
    for k = 1 : len
        sum = s(k)*2^(len-k) + sum;
    end
    %得到行向量的1DLBP直方图特征
    Histogram(sum+1) = Histogram(sum+1)+1;
end
%归一化
Histogram = Histogram/(l-m);