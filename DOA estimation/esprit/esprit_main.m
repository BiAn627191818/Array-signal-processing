clear all
close all
derad = pi/180;       %角度——>弧度
radeg = 180/pi;       %弧度——>角度
twpi = 2*pi;
kelm = 8;            %阵元数
dd = 0.5;            %阵元间距
d=0:dd:(kelm-1)*dd;
iwave = 3;          %信源数
theta = [10 20 30];  %波达方向
snr = 10;            %信噪比
n = 500;            %采样数
A = exp(-j*twpi*d.'*sin(theta*derad));   %方向向量
S = randn(iwave,n);                      %信源信号
snr0=0:3:100;                            %信噪比

for isnr=1:10
X0=A*S;                                  %接收信号
X1=awgn(X0,snr0(isnr),'measured');       %添加噪声
Rxx=X1*X1'/n;                            %计算协方差矩阵
[EV,D]=eig(Rxx);                         %特征值分解
EVA=diag(D)'
[EVA,I]=sort(EVA);                       %特征值从小到大排序
EVA=fliplr(EVA);                          %左右翻转，从大到小排序
EV=fliplr(EV(:,I));                      %对应特征向量排序
estimates=(tls_esprit(dd,Rxx,iwave));       %调用子程序
doaes(isnr,:)=sort(estimates(1,:));
end
