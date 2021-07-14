clc,clear,close all;
data=readtable('data.csv');
x=table2array(data(1:100,2));
d=table2array(data(2:101,2));
N=100;
Ntest=200;
order=20;
epsilon=0.001;
beta=0.1;
X=convmtx(x',order)';
E=zeros(1,N);
W=zeros(N,order);
W(1,:)=zeros(1,order);
mu=zeros(1,N);
E(1)=d(1)-W(1,:)*X(1,:)';
W(1,:)=W(1,:)+beta*E(1)*conj(X(1,:))/(X(1,:)*X(1,:)'+epsilon);
for k=2:N
    E(k)=d(k)-W(k-1,:)*X(k,:)';
    mu(k)=beta/(X(k,:)*X(k,:)'+epsilon);
    W(k,:)=W(k-1,:)+mu(k)*E(k)*conj(X(k,:));
end
figure 
plot(1:N,E); % The mean square error keeps decreasing 
title('Mean Square error');
xlabel('Error');
ylabel('Days');
grid on;
x=table2array(data(1:Ntest,2));
d=table2array(data(2:Ntest+1,2));
y=zeros(1,Ntest);
for i=1:Ntest
    for j=1:order
        if(i>j)
            y(i)=y(i)+W(N,j)*x(i-j);
        end
    end
end
figure
plot(d);
hold on 
plot(y);
grid on;
title('Desired signal vs estimated signal');
xlabel('Days');
ylabel('Stock market values');

