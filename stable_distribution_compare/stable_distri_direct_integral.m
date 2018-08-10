function P_stable=stable_distri_direct_integral(alpha1,gamma1,delta1,l,L)

% Simulate the symmetric stable distribution through direct integral.

m = 0.0001;
M = 10;

u=0:m:M;
phi1=-L:l:L;

cos1=cos((phi1-delta1)'*u);

P_stable=cos1*exp(-(gamma1^alpha1)*(u.^alpha1))'*m;
P_stable=P_stable/sum(P_stable*l);

end