clear all
close all
derad = pi/180;
radeg = 180/pi;
twpi=2*pi;
Melm=7;
kelm=6;
dd=0.5;
d=0:dd:(Melm-1)*dd;
iwave=3;
theta=[0 30 60];
n=200
A=exp(-j*twpi*d.'*sin(theta*derad));

%构造相干信源
S0=randn(iwave-1,n);
S=[S0(1,:);S0];
X0=A*S;
X=awgn(X0,10,'measured');
Rxxm=X*X'/n;
issp=1;                     %设置平滑算法模式

%空间平滑
if issp == 1
    Rxx=ssp(Rxxm,kelm);     %平滑算法
elseif issp == 2
    Rxx=mssp(Rxxm,kelm);    %改进的平滑算法
else
    Rxx=Rxxm;
    kelm=Melm;
end
[EV,D]=eig(Rxx);
EVA=diag(D)';[EVA,I]=sort(EVA);
EVA=fliplr(EVA),EV=fliplr(EV(:,I));

for iang = 1:361
        angle(iang)=(iang-181)/2;
        phim=derad*angle(iang);
        a=exp(-j*twpi*d(1:kelm)*sin(phim)).';
        L=iwave;
        En=EV(:,L+1:kelm);
        SP(iang)=(a'*a)/(a'*En*En'*a);
end
SP=abs(SP);
SPmax=max(SP);
SP=10*log10(SP/SPmax);
figure
h=plot(angle,SP);
set(h,'Linewidth',2)
xlabel('angle/degree')
ylabel('magnitude/dB')
axis([-90 90 -60 0])
set(gca,'Xtick',[-90:30:90],'YTick',[-60:10:0])
grid on
hold on
legend('空间平滑MUSIC')

