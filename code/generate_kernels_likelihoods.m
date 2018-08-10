% Generates kernels and likelihoods needed.

function [kernel,La1,La10,La20] = generate_kernels_likelihoods(...
    input_para,l,L,distribution_function)

alpha_k = input_para(1);gamma_k = input_para(2);
alpha_a1 = input_para(3);gamma_a1 = input_para(4);
alpha_a2 = input_para(5);gamma_a2 = input_para(6);

% Dynamical kernel
P_k = distribution_function(alpha_k,gamma_k,0.,l,4*L);
indexL = 1+3*L/l;indexR = 1+5*L/l;
kernel = zeros(1+2*L/l,1+2*L/l);
for j = 1:1+2*L/l
    kernel(j,:) = ...
        P_k(indexL+(L/l-j+1):indexR+(L/l-j+1))/sum(P_k(indexL+(L/l-j+1):indexR+(L/l-j+1))*l);
end

% Likelihood1 from the auditory input (through air)
La1 = distribution_function(alpha_a1,gamma_a1,0.,l,4*L);
La10 = distribution_function(alpha_a1,gamma_a1,0.,l,L);

% Likelihood2 from the auditory input (through bones), no shift
La20 = distribution_function(alpha_a2,gamma_a2,0.,l,L);

end