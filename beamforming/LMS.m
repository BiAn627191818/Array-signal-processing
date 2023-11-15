clear all
close all
clc
M=16;           %阵元数
K=2;            %信源数
theta=[0 30];   %信号入射角度
d=0.3;          %阵元间距
N=500;          %采样数
Meann=0; varn=1;%噪声均值、方差
SNR=20;         %信噪比
INR=20;         %信干噪比
pp=zeros(100,N);pp1=zeros(100,N);
rvar1=sqrt(varn)*10^(SNR/20);  %信号功率
rvar2=sqrt(varn)*10^(INR/20);  %干扰功率
for q=1:100
s=[rvar1*exp(j*2*pi*(50*0.001*[0:N-1]));rvar2*exp(j*2*pi*(100*0.001*[0:N-1]+rand))];  %生成源信号
A=exp(-j*2*pi*d*[0:M-1].'*sin(theta*pi/180));               %方向向量
e=sqrt(varn/2)*(randn(M,N)+j*randn(M,N));                   %噪声
Y=A*s+e;                                                    %接收信号

%LMS算法
L=200
de=s(1,:);
mu=0.0005;
w=zeros(M,1);
for k=1:N
    y(k)=w'*Y(:,k);                         %预测下一个采样和误差
e(k) = de(k)-y(k);                          %误差
w = w + mu*Y(:,k)*conj(e(k));               %调整权向量
end
end
%波束形成
beam=zeros(1,L);
for i=1:L
    a=exp(-j*2*pi*d*[0:M-1].'*sin(-pi/2+pi*(i-1)/L));
    beam(i)=20*log10(abs(w'*a));
end
%作图
figure
angle=-90:180/200:(90-180/200);
plot(angle,beam);
grid on
xlabel('方向角/degree');
ylabel('幅度响应/dB');
figure
for k=1:N
    en(k)=(abs(e(k))).^2;
end
semilogy(en);hold on
xlabel('迭代次数');
ylabel('MSE');



