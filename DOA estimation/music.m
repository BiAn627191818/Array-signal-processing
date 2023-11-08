clear all
close all
derad = pi/180;       %角度——>弧度
radeg = 180/pi;        %弧度——>角度
twpi = 2*pi;
kelm = 8;            %阵元数
dd = 0.5;            %阵元间距
d=0:dd:(kelm-1)*dd;
iwave = 3;            %信源数
theta = [10 30 60];    %波达方向
snr = 10;            %信噪比
n = 500;            %采样数
A = exp(-j*twpi*d.'*sin(theta*derad));    %方向向量
S = randn(iwave,n);                        %信源信号
X = A * S;                                %接收信号
X1 = awgn(X,snr,'measured');               %添加噪声
Rxx = X1*X1'/n;                            %计算协方差矩阵
InvS=inv(Rxx);
[EV,D]=eig(Rxx);                            %特征值分解
EVA=diag(D)'
[EVA,I]=sort(EVA);                           %特征值从小到大排序
EVA=fliplr(EVA);                               %左右翻转，从大到小排序
EV=fliplr(EV(:,I));                            %对应特征向量排序

%构造MUSIC空间谱函数
for iang = 1:361
    angle(iang)=(iang-181)/2;
    phim=derad*angle(iang);
    a=exp(-j*twpi*d*sin(phim)).';
    L=iwave;
    En=EV(:,L+1:kelm);                        %得到噪声子空间
    SP(iang)=(a'*a)/(a'*En*En'*a);
end


%作图
SP=abs(SP);
SPmax=max(SP);
SP=10*log10(SP/SPmax);
h=plot(angle,SP);
set(h,'Linewidth',2)
xlabel('angle/degree')
ylabel('magnitude/dB')
axis([-90 90 -60 0])
set(gca,'XTick',[-90:30:90])
grid on
