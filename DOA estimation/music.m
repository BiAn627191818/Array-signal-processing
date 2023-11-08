clear all
close all
derad = pi/180;
radeg = 180/pi;
twpi = 2*pi;
kelm = 8;
dd = 0.5;
d=0:dd:(kelm-1)*dd;
iwave = 3;
theta = [10 30 60];
snr = 10;
n = 500;
A = exp(-j*twpi*d.'*sin(theta*derad));
S = randn(iwave,n);
X = A * S;
X1 = awgn(X,snr,'measured');
Rxx = X1*X1'/n;
InvS=inv(Rxx);
[EV,D]=eig(Rxx);
EVA=diag(D)'
[EVA,I]=sort(EVA);
EVA=diag(D)'
[EVA,I]=sort(EVA);
EVA=fliplr(EVA);
EV=fliplr(EV(:,I));

%构造MUSIC空间谱函数
for iang = 1:361
    angle(iang)=(iang-181)/2;
    phim=derad*angle(iang);
    a=exp(-j*twpi*d*sin(phim)).';
    L=iwave;
    En=EV(:,L+1:kelm);
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