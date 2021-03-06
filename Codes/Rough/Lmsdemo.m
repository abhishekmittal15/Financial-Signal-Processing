clc
clear
t=-1:0.001:1;
f=2;
order=100;
mu=0.001;
x=sin(2*pi*f*t);
x=x+randn(1,length(x));
[b,a]=fir1(order,0.01,'LOW');
d=filter(b,a,x);
[A,E]=lms(x,d,order,mu);
y=convmtx(x,order)'*A(length(x),:)';
plot(t,d);