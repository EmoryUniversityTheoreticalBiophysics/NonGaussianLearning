%% Simulates the pitch shift experiments.

function [prior1d_baseline,prior1d_50,prior1d_100,prior1d_150,prior1d_300,...
    prior1d_stair,mean_const,mean_stair,std_const,std_stair] ...
    = songbird_single_timescale(l,L,input_para,distribution_type)



%% Input variables:

% l is the increment size.
% L is the cut-off point.

% alpha_k = input_para(1);
% gamma_k = input_para(2);
% alpha_a1 = input_para(3);
% gamma_a1 = input_para(4);
% alpha_a2 = input_para(5);
% gamma_a2 = input_para(6);

% distribution_type indicates what type of distributions are used


%% Output variables:
% prior1d_baseline: baseline distribution
% prior1d_50: prior distributions for 50-cent shift 
% prior1d_100: prior distributions for 100-cent shift
% prior1d_150: prior distributions for 150-cent shift 
% prior1d_300: prior distributions for 300-cent shift
% prior1d_stair: prior distributions for staircase shift
% mean_const: means for the 4 constant shifts
% mean_stair: means for the staircase shift
% std_const: standard deviations for the 4 constant shifts
% std_stair: standard deviations for the staircase shift


%% song acquisition, training
T0 = 20;
[prior1d_baseline,kernel,La1,La20] ...
    = song_acquisition(l,L,T0,input_para,distribution_type);


%% constant shift experiments

Tc = 14;
% 50-cent shift experiment
shift_vector = 50*ones(Tc,1);
prior1d_50 = shift_experiment(l,L,Tc,shift_vector,prior1d_baseline,kernel,La1,La20);
% 100-cent shift experiment
shift_vector = 100*ones(Tc,1);
prior1d_100 = shift_experiment(l,L,Tc,shift_vector,prior1d_baseline,kernel,La1,La20);
% 150-cent shift experiment
shift_vector = 150*ones(Tc,1);
prior1d_150 = shift_experiment(l,L,Tc,shift_vector,prior1d_baseline,kernel,La1,La20);
% 300-cent shift experiment
shift_vector = 300*ones(Tc,1);
prior1d_300 = shift_experiment(l,L,Tc,shift_vector,prior1d_baseline,kernel,La1,La20);


%% staircase experiments

shift_step = 35; % step size is 35 cents
shift_period = 6; % length of each step is 6 days
shift_repe = 8; % in total, there are 8 steps
Ts = shift_period*shift_repe; 

shift_vector = zeros(Ts,1); 
for i = 1:shift_repe
    shift_vector((i-1)*shift_period+1:i*shift_period) = i*shift_step;
end
prior1d_stair = shift_experiment(l,L,Ts,shift_vector,prior1d_baseline,kernel,La1,La20);


%% mean and standard deviation

phi1 = -L:l:L;

mean_const = zeros(1+Tc,4); 
std_const = zeros(1+Tc,4); 
mean_stair = zeros(1+Ts,1); 
std_stair = zeros(1+Ts,1);

std_const(1,1) = sqrt(sum((phi1.^2).*prior1d_baseline*l));
std_const(1,2) = sqrt(sum((phi1.^2).*prior1d_baseline*l));
std_const(1,3) = sqrt(sum((phi1.^2).*prior1d_baseline*l));
std_const(1,4) = sqrt(sum((phi1.^2).*prior1d_baseline*l));
std_stair(1,1) = sqrt(sum((phi1.^2).*prior1d_baseline*l));

% 50 cents shift
for t = 2:1+Tc
    mean_const(t,1) = sum(phi1.*prior1d_50(t-1,:)*l);
    std_const(t,1) = sqrt(sum((phi1.^2).*prior1d_50(t-1,:)*l)-mean_const(t,1)^2);
end

% 100 cents shift
for t = 2:1+Tc
    mean_const(t,2) = sum(phi1.*prior1d_100(t-1,:)*l);
    std_const(t,2) = sqrt(sum((phi1.^2).*prior1d_100(t-1,:)*l)-mean_const(t,2)^2);
end

% 150 cents shift
for t = 2:1+Tc
    mean_const(t,3) = sum(phi1.*prior1d_150(t-1,:)*l);
    std_const(t,3) = sqrt(sum((phi1.^2).*prior1d_150(t-1,:)*l)-mean_const(t,3)^2);
end

% 300 cents shift
for t = 2:1+Tc
    mean_const(t,4) = sum(phi1.*prior1d_300(t-1,:)*l);
    std_const(t,4) = sqrt(sum((phi1.^2).*prior1d_300(t-1,:)*l)-mean_const(t,4)^2);
end

% staircase shift
for t = 2:1+Ts
    mean_stair(t,1) = sum(phi1.*prior1d_stair(t-1,:)*l);
    std_stair(t,1) = sqrt(sum((phi1.^2).*prior1d_stair(t-1,:)*l)-mean_stair(t,1)^2);
end

end