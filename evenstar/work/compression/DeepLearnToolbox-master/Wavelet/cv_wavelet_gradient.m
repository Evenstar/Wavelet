
function DH=cv_wavelet_gradient(X,Z,Y,h)
n=length(X)/2;
L=length(h)/2;
YH=zeros(2*n,2*L);
YZ=zeros(2*n,2*(n+L-1));
ZH=zeros(2*(n+L-1),2*L);
for i=1:n
    for k=1:2*L
        if mod(k,2)==0 
            YH(2*i-1,k)=Z(n+L-2+k/2+i);
            YH(2*i,k)=Z(L+i-k/2);
        else
            YH(2*i-1,k)=Z(L+(1-k)/2+i-1);
            YH(2*i,k)=-Z(n+L+i+(k+1)/2-2);
        end
    end
end

for j=1:n+L-1
    for k=1:2*L
        if (2*j-2*L+k)>=1 && (2*j-2*L+k)<=2*n  %check later
        ZH(j,k)=X(2*j-2*L+k);
        end
        if (2*j+1-k)>=1 && (2*j+1-k)<=2*n    %check later
        ZH(j+n+L-1)=(-1)^k*X(2*j+1-k);
        end
    end
end

for i=1:n
    for j=1:2*(n+L-1)
        s=j+1-i;
        t=j+2-n-L-i;
        if s>=1 && s<=L
            YZ(2*i-1,j)=YZ(2*i-1,j)+h(2*L+1-2*s);
            YZ(2*i,j)=YZ(2*i,j)*h(2*L+2-2*s);
        end
        if t>=1 && t<=L
            YZ(2*i-1,j)=YZ(2*i-1,j)+h(2*t);
            YZ(2*i,j)=YZ(2*i,j)-h(2*t-1);
        end
    end
end

DH=2*(Y-X)*(YH+YZ*ZH);
end
            