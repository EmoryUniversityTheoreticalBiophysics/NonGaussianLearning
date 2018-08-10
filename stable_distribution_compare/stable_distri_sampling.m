function stable_distri_sample=stable_distri_sampling(alpha1,gamma1,delta1,L)

% Simulate a symmetric stable disribution from sampling.
% See theorem 1.19 in http://fs2.american.edu/jpnolan/www/stable/chap1.pdf

N = 1000000;
theta1=unifrnd(-pi/2,pi/2,N,1);
W=exprnd(1,N,1);
stable_sample=gamma1*(sin(alpha1*theta1)./cos(theta1).^(1/alpha1)).*(cos((alpha1-1)*theta1)./W).^((1-alpha1)/alpha1)+delta1;
stable_sample=stable_sample(stable_sample>=-L&stable_sample<=L); % L is cut-off point. pitch beyond |L| will not be considered.
stable_distri_sample=histnorm(stable_sample,2*L+1);

end