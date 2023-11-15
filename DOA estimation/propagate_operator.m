clear all
close all
derad = pi/180;
radeg = 180/pi;
twpi=2*pi;
kelm=16;            %阵元数
dd=0.5;             %阵元间距
d=0:dd:(kelm-1)*dd; 
iwave=3;            %信源数
theta=[10 20 30];   %DOA
pw =[1 0.8 0.7]';   %信号功率
nv =ones(1,kelm);   %归一化噪声方差
snr=20;             %信噪比
snr0=10^(snr/10);
n=200;              %样本数量
A=exp(-j*twpi*d.'*sin(theta*derad));  %方向矩阵
K=length(d);
cr=zeros(K,K);
L=length(theta);
data=randn(L,n);
data=sign(data);
twpi=2.0*pi;
derad=pi/180.0;
s=diag(pw)*data;
A1=exp(-j*twpi*d.'*sin([0:0.2:90]*derad));
received_signal = A*s;
cx = received_signal+diag(sqrt(nv/snr0/2))*(randn(K,n)+j*randn(K,n));
Rxx=cx*cx'/n;

%传播算子算法
G=Rxx(:,1:iwave);
H=Rxx(:,iwave+1:end);
P=inv(G'*G)*G'*H;                  %传播算子矩阵
Q=[P',-diag(ones(1,kelm-iwave))];  %Q矩阵

for iang = 1:361
    angle(iang)=(iang-181)/2;
    phim=derad*angle(iang);
    a=exp(-j*twpi*d*sin(phim)).'
    SP(iang)=1/(a'*Q'*Q*a);
end
SP=abs(SP);
SPmax=max(SP);
SP=10*log10(SP/SPmax);
%作图
figure
h=plot(angle,SP,'-k');
set(h,'Linewidth',2)
xlabel('angle/degree')
ylabel('magnitude/dB')
axis([0 60 -60 0])
set(gca,'Xtick',[0:10:60])
grid on
hold on
legend('Propagator Method ')