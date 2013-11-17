function [X]=cv_genwave_haar(n,N,density)
%Generate N signals of length 2^n using sparse haar coefficients.
%Density is the fraction of non-zero coefficients.
X=zeros(N,2^n);
L=ones(1,n+2);
for i=2:n+2
    L(i)=2^(i-2);
end
for j=1:N
C=full(sprand(1,2^(n+1),density));
X(j,:)=waverec(C,L,'db2');
end
end