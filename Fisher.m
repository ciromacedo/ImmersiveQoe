function Y =  Fisher(MC,MU,Q,DELK,Num)

m = MC*MU;
ms = MC*Q;
SNR_mean = m/((ms-1)*DELK);

Sigma=1;
Xn=random('Nakagami',m,Sigma,[1,Num]);
A=1./random('Nakagami',ms,1,[1,Num]);
R2=A.^2.*Xn.^2;

Y=SNR_mean*R2./mean(R2);
end

