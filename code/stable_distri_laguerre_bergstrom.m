% 
% sd_lb represents stable distribution with laguerre-bergstrom method.
% Check Paper 'ON THE COMPUTATION OF THE PROBABILITY DENSITY FUNCTION OF alpha-STABLE DISTRIBUTIONS'.
% In this code, the symmetric stable distribution is simulated in three parts
% separately, the central parts with the 'laguerre quadratures' method, the left
% and right tails with the Bergstrom expansion.

% This code works ok for alpha1 in range [0.2,1.9].
% For alpha1 in range [1.9,2], please refer to 
% https://www.mathworks.com/matlabcentral/fileexchange/37514-stbl--alpha-stable-distributions-for-matlab
% For alpha1 in range (0, 0.2), it is very hard to simulate, and no
% reliable and efficient algorithms are available as far as I know.

% In the folder, stable_distribution_compare, I compare stable distributions
% that are generated from different algorithms.

% The code shown below is usually much faster than other methods, since
% only the symmetric case is considered here.

function sd_lb = stable_distri_laguerre_bergstrom(alpha1,gamma1,delta1,l,L)

% The specific position of the two joint point (represented by b in
% standard stable distribution) depends on the value of alpha1.
% The conditions here are empirical, and they were chosen this way to 
% make sure that the final distribution is smooth.
if alpha1 <= 0.3
    b = 0.002;
elseif alpha1 > 0.3 && alpha1 <= 0.5
    b = 0.1;
elseif alpha1 > 0.5 && alpha1 <= 1.2
    b = 2;
elseif alpha1 > 1.2 && alpha1 <= 2
    b = 8;
end

N = 20;
n = 1:N; % N is the number of terms in the Bergstrom expansion.
% The following line calculates the weights that are associated with the N
% terms in Bergstrom expansion, which will be used later in this code.
w = (-1).^(n-1).*gamma(n*alpha1+1)./factorial(n).*sin(n*(pi*alpha1/2));

% Right joint point of laguerre and bergstrom.
right_p = round(delta1/l+b*gamma1/l)*l; 
% Left joint point of laguerre and bergstrom.
left_p = round(delta1/l-b*gamma1/l)*l; 

% Three sections of variable ranges.
phi_left = -L:l:left_p-l;
phi_mid = left_p:l:right_p;
phi_right = right_p+l:l:L;

% Three sections of stable ditribution corresponding to the three sections
% of variable ranges.
sd_left = zeros(length(phi_left),1);
sd_mid = zeros(length(phi_mid),1);
sd_right = zeros(length(phi_right),1);

% Load the l96_r and l96_w, which will be used later.
% l96_w represents weight vector. l96_r represents root vector.
load('../variables/Laguerre_zeros_of_order_96.mat');
load('../variables/Laguerre_weights_for_order_96.mat');

% l96_r = [0.0149824738627974;0.0789461230488021;0.194039436194151;0.360318499403014;0.577830599711450;0.846634333408369;1.16680157527880;1.53841793520296;1.96158297783829;2.43641040139902;2.96302821939047;3.54157895808355;4.17221987447918;4.85512319708729;5.59047639105281;6.37848244891691;7.21936020826474;8.11334469756197;9.06068751157867;10.0616572179204;11.1165397963273;12.2256391125606;13.3892774288680;14.6077959532123;15.8815554296569;17.2109367725306;18.5963417472475;20.0381937009365;21.5369383463400;23.0930446027802;24.7070054983656;26.3793391380255;28.1105897424197;29.9013287632840;31.7521560813420;33.6637012935521;35.6366250971713;37.6716207789172;39.7694158184066;41.9307736160633;44.1564953568229;46.4474220222550;48.8044365651820;51.2284662625306;53.7204852640395;56.2815173565969;58.9126389664458;61.6149824243121;64.3897395217593;67.2381653908093;70.1615827431958;73.1613865106280;76.2390489332764;79.3961251504983;82.6342593557899;85.9551915873197;89.3607652364399;92.8529353696561;96.4337779750799;100.105500262952;103.870452172084;107.731139260883;111.690237194092;115.750608075905;119.915318928456;124.187662674243;128.571182054714;133.069697009199;137.687336153659;142.428573144639;147.298268899661;152.301720884267;157.444720985795;162.733623899784;168.175428492008;173.777875317944;179.549564455495;185.500099144282;191.640262588490;197.982237918996;204.539885113378;211.329094261168;218.368242956587;225.678798523469;233.286126227831;241.220598036776;249.519153062529;258.227560816419;267.403824157099;277.123525316082;287.488696826410;298.643613699305;310.805679686186;324.334450412315;339.921409310731;359.357668285840];
% l96_w = [0.0378785762190416;0.0827199060983472;0.115866799133983;0.133832300132295;0.136433303616451;0.126286212035649;0.107692488879809;0.0853241291115908;0.0631420324252067;0.0437983823083315;0.0285464488795498;0.0175128661949781;0.0101256479675927;0.00552270259975423;0.00284340847535508;0.00138261167584397;0.000635164771717427;0.000275739969987876;0.000113136161890500;4.38751830980154e-05;1.60823977607242e-05;5.57148004833499e-06;1.82402056365088e-06;5.64234685747050e-07;1.64882294998538e-07;4.55060139337167e-08;1.18583546660761e-08;2.91679561068138e-09;6.76961168367201e-10;1.48194998367032e-10;3.05870045173782e-11;5.94951231320950e-12;1.09008410061549e-12;1.88040639182857e-13;3.05225498406800e-14;4.65925773316193e-15;6.68457363774355e-16;9.00762483656517e-17;1.13927564564574e-17;1.35149619739930e-18;1.50257584072695e-19;1.56438402019921e-20;1.52393520712534e-21;1.38776703002009e-22;1.18027527941732e-23;9.36557292314958e-25;6.92650128768910e-26;4.76915604028945e-27;3.05358836936392e-28;1.81587633956757e-29;1.00162397296068e-30;5.11764405443210e-32;2.41853783221976e-33;1.05557120068843e-34;4.24785484653033e-36;1.57345126047708e-37;5.35485308786264e-39;1.67114138623602e-40;4.77263859284026e-42;1.24461542327210e-43;2.95687462506101e-45;6.38372705378949e-47;1.24913237256843e-48;2.20904197713523e-50;3.51998649567849e-52;5.03735188828129e-54;6.45153241706474e-56;7.36679117358114e-58;7.46915246283925e-60;6.69446397277814e-62;5.27860470531753e-64;3.64251040710690e-66;2.18709474934152e-68;1.13549267145026e-70;5.06219575280061e-73;1.92309455571511e-75;6.17261978152664e-78;1.65811636693471e-80;3.68807828510871e-83;6.71100390692686e-86;9.85418710093299e-89;1.14940727690984e-91;1.04581677749342e-94;7.26695241901891e-98;3.76083100898719e-101;1.40679479390567e-104;3.66750439991905e-108;6.36965661391797e-112;6.96097784797739e-116;4.44388368113843e-120;1.49933366118530e-124;2.32112589530131e-129;1.33328383770562e-134;2.00260026596588e-140;4.02878621325045e-147;1.95741495196934e-155];

% Left tail, with bergstrom expansion. Abslute values of variable are used,
% since the stable distribution we are considering is always symmetric.
ii = 0;
while ii <= length(phi_left)-1
    ii = ii+1;
    sd_left(ii,1) = 1/(pi*abs(phi_left(ii)-delta1)/gamma1)*sum(w.*((abs(phi_left(ii)-delta1)/gamma1).^(-alpha1*n)));
end

% Middle part, with laguerre quardrature.
ii = 0;
while ii <= length(phi_mid)-1
    ii = ii+1;
    sd_mid(ii,1) = (1/pi)*sum(l96_w.*exp(l96_r-l96_r.^alpha1).*cos(((phi_mid(ii)-delta1)/gamma1)*l96_r));
end

% Right tail, with bergstrom expansion.
ii = 0;
while ii <= length(phi_right)-1
    ii = ii+1;
    sd_right(ii,1) = 1/(pi*abs(phi_right(ii)-delta1)/gamma1)*sum(w.*((abs(phi_right(ii)-delta1)/gamma1).^(-alpha1*n)));
end

% Put the three parts together in sequence.
sd_lb = [sd_left;sd_mid;sd_right];

% When left_p is smaller than -L, then the left part will disappear. The
% middle part will start from this left_p. Since the range of the variable
% should always be [-L,L], we need to delete the [left_p,-L-1] portion of the
% middle part. Before the deletion, the total length of sd_lb is
% -left_p+1+L. We need to reduce length to -(-L)+1+L = 1+2L. We count from
% the right end of the vector, and include 1+2L elements in total. 
% If right_p is bigger than L, then we should count from the left end of the vector.
if left_p < -L
    sd_lb = sd_lb((-left_p+1+L-2*L)/l:(-left_p+1+L)/l,1);
else
    % The right excessive part (if any) will be deleted automatically in this line.
    sd_lb = sd_lb(1:2*L/l+1,1); 
end
sd_lb = abs(sd_lb(:,1)/sum(sd_lb(:,1)*l));

end
