%%
%Prepare filter bank coefficients.
tic
h=[0.482962913144690 0.836516303737469 0.224143868041857 -0.129409522550921];
L=length(h)/2;
g=zeros(1,2*L);
p=zeros(1,2*L);
r=zeros(1,2*L);
for k=1:2*L
    g(k)=(-1)^(k+1)*h(2*L+1-k);
    p(k)=h(2*L+1-k);
    r(k)=(-1)^k*h(k);
end

%Test signals.
for Q=1:1
X=unifrnd(-10,10,[1,20000]);
n=length(X)/2;
Z=zeros(1,2*(n+L-1));
for i=1:(n+L-1)
    for s=1:2*L
        if 2*i-2*L+s >0 && 2*i-2*L+s <=2*n
        Z(i)=Z(i)+h(s)*X(2*i-2*L+s);
        end
    end
    for s=1:2*L
        if 2*i-2*L+s >0 && 2*i-2*L+s <=2*n
        Z(i+n+L-1)=Z(i+n+L-1)+g(s)*X(2*i-2*L+s);
        end
    end
end

Y=zeros(1,2*n);
for i=1:n
    for s=1:L
    Y(2*i-1)=Y(2*i-1)+Z(s+i-1)*p(2*s)+Z(n+L-2+s+i)*r(2*s);
    Y(2*i)=Y(2*i)+Z(s+i-1)*p(2*s-1)+Z(n+L-2+s+i)*r(2*s-1);
    end
end
sum(abs(X-Y))
end
toc


















    