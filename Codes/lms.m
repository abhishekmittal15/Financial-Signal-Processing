clc,clear,close all;
data=readtable('data.csv');
order=20;
N=100;
Ntest=200;
x=table2array(data(1:N,5))';
d=table2array(data(2:N+1,5));
energy_average=x*x'/N;
mu=2/((order+1)*energy_average);
disp(mu);
E=zeros(1,N);
w0=zeros(1,order);
W=zeros(N,order);
X=convmtx(x,order)';
E(1)=d(1)-w0*(X(1,:)');
W(1,:)=w0+mu*E(1)*conj(X(1,:));
figure
for k=2:N
    E(k)=d(k)-W(k-1,:)*(X(k,:)');
    W(k,:)=W(k-1,:)+mu*E(k)*conj(X(k,:));
%     [h,w]=freqz(W(k,:),1,order);
%     plot(1:length(h),h);
%     pause(0.1);
end
lms=dsp.LMSFilter(order,'StepSize',mu,'Method','Normalized LMS','WeightsOutputPort','true');
[yac,e,w]=step(lms,x',d);
% plot(1:100,d);
% hold on 
% plot(1:100,y);
x=table2array(data(1:Ntest,2));
y=zeros(1,Ntest);
ymine=zeros(1,Ntest);
for n=1:Ntest
    for i=1:order
        if(n>=i)
        y(n)=y(n)+w(i)*x(n-i+1);
        ymine(n)=ymine(n)+W(N,i)*x(n-i+1);
        end
    end
end
pred=zeros(1,110);
d=table2array(data(2:Ntest+1,2));
figure
plot(2:Ntest+1,d);
hold on
plot(1:Ntest,ymine)
% plot(1:Ntest,y);
grid on
legend('desired','mine','correct');
title('LMS Prediction for NIFTY 50');
xlabel('Days');
ylabel('Stock market Retusn');
for i=1:Ntest
    pred(i)=((d(i)-abs(d(i)-ymine(i)))*100)/d(i);
end
figure
plot(1:Ntest,pred);
title('prediction accuracy');
xlabel('days');
ylabel('Percentage');