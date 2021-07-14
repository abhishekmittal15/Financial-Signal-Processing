clc,clear,close all;
data=readtable('data.csv');
N=100;
true_values=table2array(data(2:N+1,2));
noisy_values=true_values+100*randn(1,N);
% I am assuming the market noise to be a gaussian random process and
% adding that noise to the actual market data. This is to replicate the
% situation where the data we have might not be accurate or might be the
% data of a particular time of the day rather than the opening data
F=1;
G=0;
H=1;
Q=100;
u=0;
y0=table2array(data(1,2));
state=zeros(1,N);
predicted=zeros(1,N);
ma=zeros(1,N);
state(1)=y0;
predicted(1)=y0;
R=0.01; % needs to be changed 
P=0.01;
for k=2:N
    predicted(k)=state(k-1);
    if(k>2) 
        predicted(k)=predicted(k)+state(k-2);
    end
    if (k>3) 
        predicted(k)=predicted(k)+state(k-3);
    end
    predicted(k)=predicted(k)/3;
    P=F*Q*F'+Q;
    K=(P*H')/(H*P*H'+R);
    state(k)=predicted(k)+K*(noisy_values(k)-H*predicted(k));
    P=(1-K)*P;
end
ma(1)=y0;
ma(2)=true_values(1);
ma(3)=(true_values(1)+true_values(2))/2;
for k=4:N
    ma(k)=(true_values(k-1)+true_values(k-2)+true_values(k-3))/3;
end
figure 
axis([0 N min(true_values) max(true_values)]);
plot(true_values);
hold on 
plot(predicted);
plot(ma);
legend('The true states','The estimated states','3 day moving average');
xlabel('Days');
ylabel('The measured and the estimated values');
title('Kalman filter ');
grid on
figure
pred=zeros(1,N);
for i=1:N
    pred(i)=(true_values(i)-abs(true_values(i)-predicted(i)))*100/true_values(i);
end
stem(pred(3:end));
ylim([ min(pred) max(pred)]);
xlabel('Days');
ylabel('Prediction Accuracy %');
title('Prediction accuracy of the Kalman Filter');