clear all
close all
clc
derad = pi/180;
radeg = 180/pi;
twpi = 2*pi;
kelm1 = 5;   %子阵1阵元数
kelm2 = 3;   %子阵2阵元数
dd = 0.5;    %阵元间距
n = 100;     %快拍数
snr = 10;    %信噪比
d1 = 0:kelm1*dd:(2*kelm2-1)*kelm1*dd;       %子阵1阵元分布(这里是2×kelm2个阵元)
d2 = 0:kelm2*dd:(kelm1-1)*kelm2*dd;         %子阵2阵元分布
theta = [10 20 30];
iwave = length(theta);                      %目标数
A1=exp(-j*twpi*d1.'*sin(theta*derad));      %子阵1阵元对应的方向矩阵
A2=exp(-j*twpi*d2.'*sin(theta*derad));      %子阵2阵元对应的方向矩阵
S=randn(iwave,n);
X01=A1*S;                                   %接收信号
X02=A2*S;
X1=awgn(X01,snr,'measured');                %加入高斯白噪声
X2=awgn(X02,snr,'measured');
Rxx1=X1*X1'/n;                              %自相关函数
Rxx2=X2*X2'/n;
InvS=inv(Rxx1);
[EV,D]=eig(Rxx1);                           %求矩阵的特征向量和特征值
EVA=diag(D)';
[EVA,I]=sort(EVA);                          %特征值按升序排序
EVA=fliplr(EVA);                            %左右翻转，特征值按降序排序
EV=fliplr(EV(:,I));
InvS1=inv(Rxx2);
[EV1,D1]=eig(Rxx2);
EVA1=diag(D1)';
[EVA1,I1]=sort(EVA1);
EVA1=fliplr(EVA1);
EV1=fliplr(EV1(:,I1));
step=0.01;                                  %步长
Angle=-90:step:90;                          %搜索范围
%子阵1谱函数
for iang=1:length(Angle)
    phim = derad*Angle(iang);
    a=exp(-j*twpi*d1*sin(phim)).';
    L=iwave;
    En=EV(:,L+1:end);                       %噪声子空间
    SP1(iang)=(a'*a)/(a'*En*En'*a);
end
SP1=abs(SP1);
SPmax1=max(SP1);
SP1=10*log10(SP1/SPmax1);
%子阵2谱函数
for iang=1:length(Angle)
    phim=derad*Angle(iang);
    a=exp(-j*twpi*d2*sin(phim)).';
    L=iwave;
    En1=EV1(:,L+1:end);
    SP2(iang)=(a'*a)/(a'*En1*En1'*a);
end
SP2=abs(SP2);
SPmax2=max(SP2);
SP2=10*log10(SP2/SPmax2);
SP=SP1+SP2;
h1=plot(Angle,SP1);            %绘制空间谱函图
set(h1,'Linewidth',2)
hold on
h2=plot(Angle,SP2);
set(h2,'Linewidth',2)
xlabel('angle/degree')
ylabel('magnitude/dB')
axis([0 60 -40 10])
set(gca,'Xtick',[-90:10:90])
grid on








