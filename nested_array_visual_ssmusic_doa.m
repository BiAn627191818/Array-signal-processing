clear all
close all
clc
%嵌套阵列SS-MUSIC算法DOA估计
derad=pi/180;
twpi=2*pi;
theta=[10 20 30];           %目标角度
snr=20;                     %信噪比
n=500;                      %快拍数
iwave=length(theta);        %目标数

dd=0.5;                     %阵元间距
N1=3;                       %第一级阵列阵元数
N2=3;                       %第二级阵列阵元数
d1=dd*(0:N1-1);             %第一级阵列阵元位置
d2=dd*(N1+(0:N2-1)*(N1+1)); %第二级阵列阵元位置
d=sort(unique([d1,d2]));    %去掉重复项
DOF=N2*(N1+1)-1;            %虚拟阵列阵元

A=exp(-j*2*pi*d.'*sin(theta*derad));   %方向向量
S=randn(iwave,n);                      %信号向量
X0=A*S;                                %阵列输出矩阵
X=awgn(X0,snr,'measured');             %模拟阵列输出信号（加入噪声）
Rxx=X*X'/n;                            %实际接收协方差矩阵
z=vec(Rxx);                            %向量化
D=[];

for i=1:length(d)
    for ii=1:length(d)
        D(i,ii)=d(i)-d(ii);            %差分阵
    end
end
Dv=vec(D);
Dv1=sort(unique(Dv));                  %去掉相同项
for i=1:length(Dv1)
    dat=Dv1(i);
    pos=find(Dv==dat);
    zt(i,1)=mean(z(pos));
end

Rz=zeros(DOF+1,DOF+1);                 %构造空间平滑矩阵
for i=1:DOF+1
    zt1=zt(i:DOF+i);
    Rz=Rz+zt1*zt1';
end
Rz=Rz/(DOF+1);                         %得到差分阵的协方差矩阵
Rz=sqrtm(Rz);

%MUSIC算法
[Enf,~]=eigs(Rz,DOF+1-iwave,'sm');     %返回M-K个小特征值作为噪声特征值
En=fliplr(Enf);
d0=0:DOF;
for iang=1:9000
    angle(iang)=iang/100;
    phim=derad*angle(iang);
    a=exp(-j*twpi*d0*0.5*sin(phim)).';
    SP(iang)=(a'*a)/(a'*En*En'*a);
end
SP=abs(SP);
SP=SP/max(SP);
SP=10*log10(SP);
[peak,ad]=findpeaks(SP);                %找出谱峰对应角度
[peak,ads]=sort(peak,'descend');        %降序排序
anglen=(ad(:,ads));
angle1=anglen/100;
angle1=angle1([1,2,3]);
angle1=sort(angle1);

h=plot(angle,SP,'-black');              %得到空间谱图
set(h,'Linewidth');
axis([0 40 -60 0])
xlabel('angle/degree')
ylabel('magnitude/dB')