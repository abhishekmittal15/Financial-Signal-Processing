clc,clear,close all;
N=100;
order=100;
data=readtable('data.csv');
x=table2array(data(1:N,2))';
d=table2array(data(2:N+1,2));
delta=0.01;
X=convmtx(x,order)';
% Initialisation 
lambda=0.98;
% if lambda is 1 then all the past values are given same importance
P=eye(order)/delta;
W=zeros(N,order);
z=P*X(1,:)';
g=z/(lambda+X(1,:)*z);
alpha=d(1);
W(1,:)=alpha*g';
P=(P-g*z')/lambda;
for k=2:N
    z=P*X(k,:)';
    g=z/(lambda+X(k,:)*z);
    alpha=d(k)-X(k,:)*W(k-1,:)';
    W(k,:)=W(k-1,:)+alpha*g';
    P=(P-g*z')/lambda;
    disp(k);
    disp(W(k,:));
end
y=zeros(1,250);
x=table2array(data(1:250,2));
for i=1:250
    for j=1:order
        if(i>j)
            y(i)=y(i)+W(N,j)*x(i-j);
        end
    end
end
d=table2array(data(2:251,2));
figure
plot(d);
hold on 
plot(y);
grid on
title('Estimation using RLS ');
legend('Actual Signal','Predicted signal','best');
xlabel('Days');
ylabel('Returns');
figure;
for i=1:order
    plot(1:N,W(:,i));
    hold on;
    grid on;
end
figure 
pred=zeros(1,250);
for i=1:250
    pred(i)=(d(i)-abs(d(i)-y(i)))*100/d(i);
end
plot(pred);
title('Prediction accuracy of RLS filter');
axis([5 250 60 100]);
grid on 