%创建矩阵
%1
clear
A=[1 3 5;2 4 6;7 8 9];
A
% 在第一个%%以前的代码自动成为一节
% 这里11-16行是一节，光标放在其中任何一行，该节的背景色会高亮
% 编辑器菜单-运行节，只运行当前节，方便调试代码，快捷键：ctrl+回车(Enter) 
%%
% 用%%表示分节，直到下一个%%之前是一节
%2 zero函数：创建全0矩阵
clear
A=zeros(3);
A

%% 分节后空格，可以注释文字，这是第三节
clear
%%不带空格写就不行了，这样不能分节，只是一行注释
A=zeros(2,3);
A

%% 
%3 eyes函数：创建单位矩阵
clear
A=eye(3,4);
A
%% 
%4 ones函数：创建全1矩阵
clear
A=ones(3);
A
%% 
clear
A=ones(2,4);
A
%% 
%5 rand函数:创建均匀分布随机矩阵
clear
A=rand(3,5);
A
%% 
%6 randn函数:创建正态分布随机矩阵
clear
A=randn(3,5);
A
%% 
%7 hankel函数:创建Hankel矩阵
n=[3 2 1];
m=[1 5 9];
A=hankel(n,m);
A
%% 
%
A=hankel(n);
A
%% 
%8 toeplitz函数:创建Toeplitz矩阵
n=[1 2 3];
m=[1 5 9];
A=toeplitz(n);
A
%% 
%
A=toeplitz(n,m);
A
%% 
%9 det函数:求方阵的行列式
A=[1 3 6;2 4 5;1 2 3];
A
det(A)
%% 
%10 inv函数:求方阵的逆矩阵
A=[1 3 6;2 4 5;1 2 3];
inv(A)
%% 
%11 pinv函数:求矩阵的伪逆矩阵
A=[1 3 6;2 4 5;1 2 3;1 1 1];
pinv(A)
%% 
%12 rank函数:求矩阵的秩
A=[1 3 6;2 4 5;1 2 3];
rank(A)
%% 
%13 diag函数:抽取矩阵对角线元素
A=[1 3 6;2 4 5;1 2 3];
m=diag(A);
m
%% 
%
m=[1,2,3];
A=diag(m);
A
%% 
%14 fliplr函数:矩阵左右翻转
A=[1 3 6;2 4 5;1 2 3];
A
fliplr(A)
%% 
%15 eig函数:矩阵特征值分解
A=[1 3 6;2 4 5;1 2 3];
[V,D]=eig(A);
V
D
%% 
%16 svd函数:矩阵的奇异值分解
A=[1 3 6;2 4 5;1 2 3];
[U,S,V]=svd(A);
U
S
V
%% 
%17 矩阵转置和共轭转置
A=randn(2,3)+j*randn(2,3); %创建一个复矩阵
A
A'
A.'
%% 
%18 awgn函数:添加高斯白噪声
X=randn(2,5);%产生一个随机信号
X
Y=awgn(X,10,'measured');%添加高斯白噪声,信噪比为10dB
Y
%% 
%19-24 sin,cos,tan,asin,acos,atan
sin(45*pi/180)
cos(45*pi/180)
tan(45*pi/180)
asin(0.7071)
acos(0.7071)
atan(1)
%% 
%25 abs函数:求复数的模
a=-1;
b=1+1j;
abs(a)
abs(b)
%% 
%26 angle函数:求复数的相位角
a=1+1j
angle(a)
%% 
%27 real函数:求复数的实部
a=1+1j
real(a)
%% 
%28 imag函数:求复数的虚部
a=1+1j
imag(a)
%% 
%29 sum函数:求和函数
A=[1 3 6;2 4 5;1 2 3;1 1 1];
sum(A,1)
sum(A,2)
sum(A)
%% 
%30 max函数:求最大值函数
A=[1 3 6;2 4 5;1 2 3;1 1 1];
max(A,[],1)
max(A,[],2)
max(A)
%% 
%31 min函数:求最小值函数
A=[1 3 6;2 4 5;1 2 3;1 1 1];
min(A)
min(A,[],1)
min(A,[],2)
%% 
%32 sort函数:排序函数
A=[1 10 3;5 2 6;3 4 8]
disp('-------1------');
A
disp('-------2------');
sort(A)
disp('-------3------');
sort(A,1)
disp('-------4------');
sort(A,2)
disp('-------5------');
sort(A,'descend')
disp('-------6------');
[B,V]=sort(A)
%% 
%33 ploy2sym函数:创建多项式
c=[1 2 5 7];
y=poly2sym(c);
y
%% 
%34 sym2poly函数:符号多项式转换为数值多项式
syms x;
y=x^3+2*x^2+5*x+7;
c=sym2poly(y);
c
%% 
%35 roots函数:多项式求根
c=[1,2,5,7];
r=roots(c);
r
%% 
%36 size函数:求矩阵大小
A=[1,2,3,4;5 6 7 8];
A
[m,n]=size(A);
m
n