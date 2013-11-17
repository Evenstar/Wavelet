import numpy as np
class Wavelet:
    def __init__(self,h=[0.482962913144690,0.836516303737469,0.224143868041857,-0.129409522550921]):
        self.h=np.array(h)
        self.L=len(h)/2
        self.g=np.zeros(self.L*2)
        self.p=np.zeros(self.L*2)
        self.r=np.zeros(self.L*2)
        for k in range(2*self.L):
            self.g[k]=(-1)**k*self.h[2*self.L-1-k]
            self.p[k]=self.h[2*self.L-1-k]
            self.r[k]=(-1)**(k+1)*self.h[k]

    def wavedec(self,X):
        self.n=len(X)/2
        n=self.n
        L=self.L
        Z=np.zeros(2*(n+L-1))
        for i in xrange(n+L-1):
            for s in xrange(2*L):
                if 2*i-2*L+s+2>=0 and 2*i-2*L+s+2<2*n:
                    Z[i]+=self.h[s]*X[2*i-2*L+s+2]
                    Z[i+n+L-1]+=self.g[s]*X[2*i-2*L+s+2]
        return Z
     
    def waverec(self, Z):
        n=self.n
        L=self.L
        Y=np.zeros(2*n)
        for i in xrange(n):
            for s in xrange(L):
                Y[2*i]+=Z[s+i]*self.p[2*s+1]+Z[n+L+s+i-1]*self.r[2*s+1]
                Y[2*i+1]+=Z[s+i]*self.p[2*s]+Z[n+L+s+i-1]*self.r[2*s]
        return Y
import time
cv=Wavelet()
x=np.random.uniform(-10,10,size=2000)
start=time.time()
for i in range(1):
    z=cv.wavedec(x)
    y=cv.waverec(z)
    #print np.sum(np.abs(y-x))
end=time.time()
print end-start
