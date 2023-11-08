function estimate = tls_esprit(dd,cr,Le)
twpi = 2.0*pi;
derad = pi / 180.0;
radeg = 180.0 / pi;

%对接收信号协方差矩阵进行特征值分解
[K,KK]=size(cr);
[V,D]=eig(cr);
EVA=real(diag(D)');
[EVA,I]=sort(EVA);
EVA=fliplr(EVA);
EV=fliplr(V(:,I));

%构造E_{xy}和E_{xyz}=E_{xy}^H E_{xy}
Exy=[EV(1:K-1,1:Le) EV(2:K,1:Le)];
E_xys = Exy'*Exy;

%对E_xyz进行特征值分解
[V,D]=eig(E_xys);
EVA_xys = real(diag(D)');
[EVA_xys,I]=sort(EVA_xys);
EVA_xys = fliplr(EVA_xys);
EV_xys=fliplr(V(:,I));

%将EV_xys分解
Gx=EV_xys(1:Le,Le+1:Le*2);
Gy=EV_xys(Le+1:Le*2,Le+1:Le*2);

%计算Psi=-Gx [Gy]^{-1}
Psi = -Gx/Gy;
%对Psi进行特征值分解
[V,D]=eig(Psi);
EGS = diag(D).';
[EGS,I]=sort(EGS);
EGS = fliplr(EGS);
EVS = fliplr(V(:,I));

%估计DOA
ephi=atan2(imag(EGS),real(EGS));
ange=-asin(ephi/twpi/dd)*radeg;
estimate(1,:)=ange;

%功率估计
T=inv(EVS);
powe = T*diag(EVA(1:Le)-EVA(K))*T';
powe = abs(diag(powe).')/K;
estimate(2,:)=powe;
