% Simulate the shift experiment

function prior1d = shift_experiment(l,L,T,shift_vector,prior1d_input,kernel,La1,La20)
        
% T: number of days

% shift_vector: imposed shift size or error size, the length of which
% should be T

% prior1d_input: input prior as the starting point

% kernel,La1,La20: outputs of the function song_acquisition

LL = 2*L/l+1;
prior1d = zeros(T+1,LL);
prior1d(1,:) = prior1d_input(:);

% Apply the Bayesian filter for T times
for t =2:T+1
    La1_s = get_shifted_likelihood(l,L,La1,shift_vector(t-1));
    prior1d(t,:) = dynamical_Bayesian(l,prior1d(t-1,:),kernel,La1_s,La20);
end

prior1d = prior1d(2:end,:);
             
end