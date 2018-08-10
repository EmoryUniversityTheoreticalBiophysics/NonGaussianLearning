% Simulates the song acquisition period during which the 
% bird begins to sing and gradually refines its song until the beginning 
% of the adulthood.

function [prior1d_baseline,kernel,La1,La20] = ...
    song_acquisition(l,L,T0,input_para,distribution_type)

% input_para contains all and only the trainable parameters of the model, 
% which define the shapes of the distributions.

% distribution_type indicates what type of distributions are used

% T0 indicates number of training days. l is the resolution. L is the 
% cutoff point.

if distribution_type == 'stable'
    [kernel,La1,La10,La20] = generate_kernels_likelihoods(...
        input_para,l,L,@stable_distri_laguerre_bergstrom);
elseif distribution_type == 'powerlaw'
    [kernel,La1,La10,La20] = generate_kernels_likelihoods(...
        input_para,l,L,@powerlaw_distribution);
end

% Start from a flat distribution
LL = 2*L/l+1;
prior1d = zeros(T0,LL);
prior1d(1,:) = ones(LL)/sum(ones(LL)*l);

% Apply the Bayesian filter for T0-1 times.
for t = 2:T0
    prior1d(t,:) = dynamical_Bayesian(l,prior1d(t-1,:),kernel,La10,La20);
end

prior1d_baseline = prior1d(T0,:);

end