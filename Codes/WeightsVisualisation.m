clc,clear,close all;
N=100;
data=readtable('data.csv');
x=table2array(data(1:N,2));
d=table2array(data(2:N+1,2));
rx0=(x'*x)/N;
rdx0=(d'*x)/N;
rd0=(d'*d)/N;
rx1=0;rdx1=0;
for k=2:N
    rx1=rx1+x(k)*x(k-1);
    rdx1=rdx1+d(k)*x(k-1);
end
rx1=rx1/N-1;
rdx1=rdx1/N-1;
w1=-10:0.01:10;
w2=-10:0.01:10;
[x1,x2]=meshgrid(w1,w2);
error=rd0-2*rdx0*x1-2*rdx1*x2+(x1.^2)*rx0+2*x1.*x2*rx1+(x2.^2)*rx0;
val=min(min(error));
disp(val);
mesh(x1,x2,error);
