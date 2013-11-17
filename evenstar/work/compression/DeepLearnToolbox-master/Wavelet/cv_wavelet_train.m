function [E H]=cv_wavelet_train(X,h,nep)
    H=h;
    for i=1:nep
    [E Z Y]=cv_wavelet_forward(X,H);
    a=0.0001;
    DH=cv_wavelet_gradient(X,Z,Y,H);
    H=H-a*DH;
end
   [E Z Y]=cv_wavelet_forward(X,H);

    