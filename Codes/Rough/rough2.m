clc
close all
clear
N=input('length of sequence N = ');
t=0:N-1;
w0=1;  phi=0.1;
for i=1:N
d(i)=sin(2*pi*i*w0+phi);
end
x=d+randn(1,N)*0.5;
w=zeros(1,N); 
mu=input('mu = ');
for i=1:N
   e(i) = d(i) - w(i)' * x(i);
   w(i+1) = w(i) + mu * e(i) * x(i);
end
for i=1:N
yd(i) = sum(w(i)' * x(i));  
end
subplot(221),plot(t,d),ylabel('Desired Signal'),
subplot(222),plot(t,x),ylabel('Input Signal+Noise'),
subplot(223),plot(t,e),ylabel('Error'),
subplot(224),plot(t,yd),ylabel('Adaptive Desired output');