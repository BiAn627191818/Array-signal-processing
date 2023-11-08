clear all
close all
derad = pi/180;
radeg = 180/pi;
twpi = 2*pi;
kelm = 8;
dd = 0.5;
d=0:dd:(kelm-1)*dd;
iwave = 3;
theta = [10 20 30];
snr = 10;
n = 500;
A = exp(-j*twpi*d.'*sin(theta*derad));
S = randn(iwave,n);
snr0=0:3:100;

for isnr=1:10
X0=A*S;
X1=awgn(X0,snr0(isnr),'measured');
Rxx=X1*X1'/n;
[EV,D]=eig(Rxx);
EVA=diag(D)'
[EVA,I]=sort(EVA);
EVA=fliplr(EVA);
EV=fliplr(EV(:,I));
estimates=(tls_esprit(dd,Rxx,iwave));
doaes(isnr,:)=sort(estimates(1,:));
end
