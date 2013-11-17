%%
m=100;
X=unifrnd(-2,2,[m,128]);
H=unifrnd(-2,2,[1,4]);
for i=1:20
    for k=1:m
        [E H]=cv_wavelet_train(X(k,:),H,1);
    end
    norm(E,2)
end
        