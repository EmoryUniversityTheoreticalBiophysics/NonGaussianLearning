%% Simulates the dynamical Bayesian filter with two sensory inputs.

function new_prior = ...
    dynamical_Bayesian(l,current_prior,kernel,likelihood1,likelihood2)

% l is the simulation resolution, and usually, it is chosen to be 1.
% prior is the current prior.
% kernel is the temporal propagator.
% likelihood1 and likelihood2 are the two likelihoods.

% Total likelihood
L_total = (likelihood1.*likelihood2)';
L_total = L_total/sum(L_total*l);
% Posterior
posterior = current_prior.*L_total; 
posterior = posterior/sum(posterior*l); 
% Propagation
new_prior = kernel*posterior'*l; 
new_prior = new_prior/sum(new_prior*l);

end