function stable_distri_compare(alpha1,gamma1,delta1,l,L)

% This code will compare symmetric stable distributions produced using 
% different methods.

% alpha1, gamma1, and delta1 are three parameters of the symmetric stable
% distribution, where alpha1 is the type, gamma1 is the scale and delta1
% is the center.

% l is the incremental size, L is the cut-off point.

% 1. P_stable is produced directly from the generation function.
% 2. stable_distri_sample is produced from sampling.
% 3. stable_distri_laguerre_bergstrom is produced using 'two quadrature'
% method, which is the one used in the songbird project. It can run much
% faster than others for most of the alpha values.
% 4. Cauchy_Distri is cauchy distribution. Thus, in this code, alpha1
% = 1.

% Direct integral
fprintf('time efficiency of direct integral is:')
tic;
P_stable = stable_distri_direct_integral(alpha1,gamma1,delta1,l,L);
toc;

% Sampling
fprintf('time efficiency of sampling method is:')
tic;
stable_distri_sample = stable_distri_sampling(alpha1,gamma1,delta1,L);
toc;

% Laguerre_Bergstrom
fprintf('time efficiency of laguerre_bergstrom is:')
tic;
laguerre_bergstrom = stable_distri_laguerre_bergstrom(alpha1,gamma1,delta1,l,L);
toc;

% mveillette
fprintf('time efficiency of mveillette is:')
tic;
p_mveillette = stblpdf_nor(alpha1,0,gamma1,delta1,l,L);
toc;

if alpha1 == 1
    fprintf('time efficiency of direct Cauchy is:')
    tic;
    x=-L:l:L;
    Cauchy_Distri=(gamma1/pi)*(1./(gamma1^2+x.^2));
    Cauchy_Distri=Cauchy_Distri/sum(Cauchy_Distri*l);
    toc;
    
    figure;hold;
    plot(-L:l:L,P_stable,'b','LineWidth',1);
    plot(-L:L,stable_distri_sample,'g','LineWidth',1);
    plot(-L:l:L,laguerre_bergstrom,'r','LineWidth',1);
    plot(-L:l:L,p_mveillette,'m','LineWidth',1);
    plot(-L:l:L,Cauchy_Distri,'k','LineWidth',1);
    legend ('integral','sampling','quadrature','mveillette','Cauchy');
    xlim([-L,L]);
    ax=gca;
    axis square;
    ax.YScale='log';
    hold;
else
    figure;hold;
    plot(-L:l:L,P_stable,'b','LineWidth',1);
    plot(-L:L,stable_distri_sample,'g','LineWidth',1);
    plot(-L:l:L,laguerre_bergstrom,'r','LineWidth',1);
    plot(-L:l:L,p_mveillette,'m','LineWidth',1);
    legend ('integral','sampling','quadrature','mveillette');
    xlim([-L,L]);
    ax=gca;
    axis square;
    ax.YScale='log';
    hold;
end



end
