clc;
close all
clear all;
M=18 ;          %阵元数
L=100 ;         %快拍数
thetas=10 ;     %信号入射角度
thetai=[-30 30];%干扰入射角度
n=[0:M-1]';

vs=exp(-j*pi*n*sin(thetas/180*pi)); %信号方向向量
vi=exp(-j*pi*n*sin(thetai/180*pi)); %干扰方向向量
f=16000;                            %信号频率
t=[0:1:L-1]/200;
snr=10;                             %信噪比
inr=10;                             %信干噪比
xs=sqrt(10^(snr/10))*vs*exp(j*2*pi*f*t);  %构造有用信号
xi=sqrt(10^(inr/10)/2)*vi*[randn(length(thetai),L)+j*randn(length(thetai),L)];
%构造干扰信号
noise=[randn(M,L)+j*randn(M,L)]/sqrt(2);    %噪声
X=xi+noise;                                 %含噪信号
R=X*X'/L;                                   %构造协方差矩阵
wop1=inv(R)*vs/(vs'*inv(R)*vs);             %波束形成
sita=48*[-1:0.001:1];                       %波束形成
v=exp(-j*pi*n*sin(sita/180*pi));            %扫描方向范围
B=abs(wop1'*v);                             %扫描方向向量
plot(sita,20*log10(B/max(B)),'k');
title('波束图');
xlabel('角度/degree');
ylabel('波束幅度/dB');
grid on
axis([-48 48 -50 0]);
hold off