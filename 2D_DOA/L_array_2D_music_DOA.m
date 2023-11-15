clear all
close all
clc
twpi = 2*pi;
rad = pi/180;
deg = 180/pi;
kelm = 8;                  %x轴、y轴各自的阵列数量
snr = 10;                  %信噪比
iwave = 3;                 %目标数
theta = [10 30 50];
fe = [15 25 35];
n = 100;                   %快拍数
dd = 0.5;                  %均匀阵列阵元间距
d = 0:dd:(kelm-1)*dd;      %x轴阵元分布
d1 = dd:dd:(kelm-1)*dd;    %y轴阵元分布
Ax = exp(-j*twpi*d.'*(sin(theta*rad).*cos(fe*rad)));   %x轴上阵元对应的方向矩阵
Ay = exp(-j*twpi*d1.'*(sin(theta*rad).*sin(fe*rad)));  %y轴上阵元对应的方向矩阵
A = [Ax;Ay];
S = randn(iwave,n);
X = A*S;                   %接收信号
X1 = awgn(X,snr,'measured')%加入高斯白噪声
Rxx = X1*X1'/n;            %自相关函数
[EV,D]=eig(Rxx);           %求矩阵的特征向量和特征值
[EVA,I]=sort(diag(D).');   %特征值按升序排列
EV=fliplr(EV(:,I));        %左右翻转，特征值按降序排序
Un=EV(:,iwave+1,end);      %噪声子空间
%按照方位角，仰角在0~89°范围内(取步长为1)构造空间谱函数
for ang1=1:90
    for ang2 = 1:90
        thet(ang1)=ang1-1;
        phim1=thet(ang1)*rad;
        f(ang2)=ang2-1;
        phim2=f(ang2)*rad;
        a1=exp(-j*twpi*d.'*sin(phim1)*cos(phim2));
        a2=exp(-j*twpi*d1.'*sin(phim1)*sin(phim2));
        a=[a1;a2];
        SP(ang1,ang2)=1/(a'*Un*Un'*a);
    end
end
SP=abs(SP);
SPmax=max(max(SP));
SP = SP/SPmax;
h=mesh(thet,f,SP);       %绘制空间谱图
set(h,'Linewidth',2)
xlabel('elevation/degree')
ylabel('azimath/degree')
zlabel('magnitude/dB')
