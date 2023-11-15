clear all
close all
derad = pi/180;
radeg = 180/pi;
twpi = 2*pi;
kelm = 8;                               %阵元间距
dd = 0.5;                               %阵元分布
d =-(kelm-1)/2*dd:dd:(kelm-1)/2*dd;     %目标数
iwave = 3;
theta1 = [10 20 30];
theta2 = [20 25 15];
snr = 20;                               %信噪比(dB)
n = 200;                                %快拍数
A0 = exp(j*twpi*d.'*(sin(theta1*derad).*cos(theta2*derad)))/sqrt(kelm);     %方向矩阵
A1 = exp(j*twpi*d.'*(sin(theta1*derad).*sin(theta2*derad)))/sqrt(kelm);     %方向矩阵
S = randn(iwave,n)
X0 =[];
for im=1:kelm
    X0=[X0;A0*diag(A1(im,:))*S];
end
X=awgn(X0,snr,'measured');
L=iwave;
J1=eye(kelm-1,kelm);
J2=flipud(fliplr(J1));
Q=qq(kelm);
Y=kron(Q',Q')*X;
Q0=qq(kelm-1);
K1=real(Q0'*J2*Q);
K2=imag(Q0'*J2*Q);
I=eye(kelm);
Ku1=kron(I,K1);
Ku2=kron(I,K2);
Kv1=kron(K1,I);
Kv2=kron(K2,I);
E=[real(Y),imag(Y)];
Ey=E*E'/n;
[V,D]=eig(Ey);
EVAs=diag(D).';
[EVAs,I0]=sort(EVAs);
EVAs=fliplr(EVAs);
EVs=fliplr(V(:,I0));
Es=EVs(:,1:L);
fiu=pinv(Ku1*Es)*Ku2*Es;
fiv=pinv(Kv1*Es)*Kv2*Es;
F=fiu+j*fiv;
[VV,DD]=eig(F);
EVA=diag(DD).';
u=2*atan(real(EVA))/pi;      %估计出u
v=2*atan(imag(EVA))/pi;      %估计出v
%估计出DOA
theta10=asin(sqrt(u.^2+v.^2))*radeg
theta20=atan(v./u)*radeg









