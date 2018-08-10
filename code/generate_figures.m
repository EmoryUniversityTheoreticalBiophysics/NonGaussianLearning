%% Generates figures shown in the paper https://arxiv.org/abs/1707.07247.

function generate_figures

%% Parameters used
l = 1;L = 800;
T = 14;Tw = 0;Ts = 48;

axfontSize = 12;
axlineWidth = 1;

red_level = 0.5;
blue_level = 0.5;
green_level = 0.5;
cyan_level = 0.5;
magenta_level = 0.5;

shift50_color = [red_level 0 0];
shift100_color = [0 0 blue_level];
shift150_color = [0 green_level 0];
shift300_color = [0 cyan_level cyan_level];
shiftStair_color = [magenta_level 0 magenta_level];
baseline_color = [0.5 0.2 0.1];

capsize = 0;


%% Load the data
load('../data/data_for_figures.mat');


%% Figure 2. Fitting.
load('../variables/mean_std_on_curve_logScale_stable.mat');
load('../variables/Gaussian_fit.mat');
bound_baseline_distribution = sqrt(abs(baseline_distribution_square/Z-(baseline_distribution_average/Z).^2));
bound_mean_constantshift_r = sqrt(abs(mean_constantshift_r_square/Z-(mean_constantshift_r_average/Z).^2));
bound_mean_staircase = sqrt(abs(mean_staircase_square/Z-(mean_staircase_average/Z).^2));
bound_d47_distribution = sqrt(abs(d47_distribution_square/Z-(d47_distribution_average/Z).^2));
bound_std_constantshift = sqrt(abs(std_constantshift_square/Z-(std_constantshift_average/Z).^2));
bound_std_staircase = sqrt(abs(std_staircase_square/Z-(std_staircase_average/Z).^2));

figure
h(1) = subplot(1,3,1);
hold on;
h(2) = subplot(1,3,2);
hold on;
h(3) = subplot(1,3,3);
hold on;

axes(h(1))
plot(0:T+Tw,mean_constantshift_r_average(1:(T+Tw+1))/Z,'Color',shift50_color,'LineWidth',2);
plot(0:T+Tw,mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z,'Color',shift100_color,'LineWidth',2);
plot(0:T+Tw,mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z,'Color',shift150_color,'LineWidth',2);
plot(0:T+Tw,mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z,'Color',shift300_color,'LineWidth',2);
shade_edge_constantshift_up1 = mean_constantshift_r_average(1:(T+Tw+1))/Z+bound_mean_constantshift_r(1:(T+Tw+1));
shade_edge_constantshift_down1 = mean_constantshift_r_average(1:(T+Tw+1))/Z-bound_mean_constantshift_r(1:(T+Tw+1));
shade_edge_constantshift_up2 = mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z+bound_mean_constantshift_r((T+Tw+2):2*(T+Tw+1));
shade_edge_constantshift_down2 = mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z-bound_mean_constantshift_r((T+Tw+2):2*(T+Tw+1));
shade_edge_constantshift_up3 = mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z+bound_mean_constantshift_r(2*(T+Tw+1)+1:3*(T+Tw+1));
shade_edge_constantshift_down3 = mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z-bound_mean_constantshift_r(2*(T+Tw+1)+1:3*(T+Tw+1));
shade_edge_constantshift_up4 = mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z+bound_mean_constantshift_r(3*(T+Tw+1)+1:4*(T+Tw+1));
shade_edge_constantshift_down4 = mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z-bound_mean_constantshift_r(3*(T+Tw+1)+1:4*(T+Tw+1));
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up1',fliplr(shade_edge_constantshift_down1')],shift50_color,'FaceAlpha',0.3,'EdgeColor','none');
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up2',fliplr(shade_edge_constantshift_down2')],shift100_color,'FaceAlpha',0.3,'EdgeColor','none');
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up3',fliplr(shade_edge_constantshift_down3')],shift150_color,'FaceAlpha',0.3,'EdgeColor','none');
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up4',fliplr(shade_edge_constantshift_down4')],shift300_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar(0:14,mean_average_constantshift_r(1:15),se_total_constantshift_r(1:15),'o','Color',shift50_color,'MarkerSize',6,...
    'MarkerFaceColor',shift50_color,'CapSize',capsize,'LineWidth',1);
errorbar(0:14,mean_average_constantshift_r(16:30),se_total_constantshift_r(16:30),'s','Color',shift100_color,'MarkerSize',6,...
    'MarkerFaceColor',shift100_color,'CapSize',capsize,'LineWidth',1);
errorbar(0:14,mean_average_constantshift_r(31:45),se_total_constantshift_r(31:45),'d','Color',shift150_color,'MarkerSize',6,...
    'MarkerFaceColor',shift150_color,'CapSize',capsize,'LineWidth',1);
errorbar([0:8,10:14],mean_average_constantshift_r([46:53,55:60]),se_total_constantshift_r([46:53,55:60]),'^','Color',shift300_color,'MarkerSize',6,...
    'MarkerFaceColor',shift300_color,'CapSize',capsize,'LineWidth',1);
plot(9,mean_average_constantshift_r(54),'^','Color',shift300_color,'MarkerSize',6,'LineWidth',1);
ax=gca;
axis square;
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,0.5+T+Tw];
ax.XTick=[0 7 14 21 28];
ax.YLim=[-10,130];
ax.YTick=[0 50 100];
xlabel('Day','FontSize',axfontSize);
ylabel ('Pitch change (in percentage)','FontSize',axfontSize);

axes(h(2));
shade_edge_staircase_up = abs(mean_staircase_average(1:1+Ts))/Z+bound_mean_staircase;
shade_edge_staircase_down = abs(mean_staircase_average(1:1+Ts))/Z-bound_mean_staircase;
plot(0:Ts,abs(mean_staircase_average(1:1+Ts))/Z,'Color',shiftStair_color,'LineWidth',2);
fill([0:Ts,fliplr(0:Ts)],[shade_edge_staircase_up',fliplr(shade_edge_staircase_down')],shiftStair_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar([0:38,40:42],mean_average_staircase([1:39,41:43]),se_total_staircase([1:39,41:43]),'v','Color',shiftStair_color,'MarkerSize',6,...
    'MarkerFaceColor',shiftStair_color,'CapSize',capsize,'LineWidth',1);
plot([39,43:47],mean_average_staircase([40,44:48]),'v','Color',shiftStair_color,'MarkerSize',6);
for ii = 1:7
    plot((ii-1)*6+1:ii*6,ii*35*ones(6,1),':','Color',[0 0 0],'LineWidth',2);
end
ax=gca;
axis square;
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,49];
ax.XTick=[0 12 24 36 48];
ax.YLim=[-10,300];
ax.YTick=[0 100 200 300];
ax.YTickLabel=[0 1.0 2.0 3.0];
xlabel ('Day','FontSize',axfontSize);
ylabel ('Pitch change (semitone)','FontSize',axfontSize);

axes(h(3));
shade_edge_baseline_up = baseline_distribution_average/Z+bound_baseline_distribution;
shade_edge_baseline_down = baseline_distribution_average/Z-0.4*bound_baseline_distribution;
histnorm(baseline_distribution,sqrt(length(baseline_distribution)));
h = findobj(gca,'Type','patch');
h.EdgeColor = baseline_color;
h.LineWidth = axlineWidth;
plot(-L:l:L,Gaussian_fit,'Color',[0.5 0.5 0.5],'LineWidth',1);
plot(-L:l:L,baseline_distribution_average/Z,'Color',baseline_color,'LineWidth',2);
fill([-L:l:L,fliplr(-L:l:L)],[shade_edge_baseline_up,fliplr(shade_edge_baseline_down)],baseline_color,'FaceAlpha',0.3,'EdgeColor','none');
ax=gca;
axis square;
ax.YScale='log';
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-400,400];
ax.XTick=[-400,-200,0,200,400];
ax.XTickLabel=[-4.0,-2.0,0,2.0,4.0];
ax.YLim=[10^-7,10^-1];
ax.YTick=[10^-6,10^-4,10^-2];
xlabel ('Pitch sung by birds (semitone)','FontSize',axfontSize);
ylabel ('Probability density','FontSize',axfontSize);

letter_x = -0.02;
letter_y = 1.15;

subplot(1,3,1)
text(letter_x,letter_y,'(A)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)

subplot(1,3,2)
text(letter_x,letter_y,'(B)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)

subplot(1,3,3)
text(letter_x,letter_y,'(C)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)

% Inset
inset = axes('Position',[0.21 0.70 0.13 0.26]);
hold;
plot(0:T+Tw,0.5*mean_constantshift_r_average(1:(T+Tw+1))/Z,'Color',shift50_color,'LineWidth',1);
plot(0:T+Tw,1.0*mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z,'Color',shift100_color,'LineWidth',1);
plot(0:T+Tw,1.5*mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z,'Color',shift150_color,'LineWidth',1);
plot(0:T+Tw,3.0*mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z,'Color',shift300_color,'LineWidth',1);

ms = 4;
errorbar(0:14,0.5*mean_average_constantshift_r(1:15),0.5*se_total_constantshift_r(1:15),'o','Color',shift50_color,'MarkerSize',ms,...
    'MarkerFaceColor',shift50_color,'CapSize',capsize,'LineWidth',0.5);
errorbar(0:14,1.0*mean_average_constantshift_r(16:30),1.0*se_total_constantshift_r(16:30),'s','Color',shift100_color,'MarkerSize',ms,...
    'MarkerFaceColor',shift100_color,'CapSize',capsize,'LineWidth',0.5);
errorbar(0:14,1.5*mean_average_constantshift_r(31:45),1.5*se_total_constantshift_r(31:45),'d','Color',shift150_color,'MarkerSize',ms,...
    'MarkerFaceColor',shift150_color,'CapSize',capsize,'LineWidth',0.5);
errorbar([0:8,10:14],3.0*mean_average_constantshift_r([46:53,55:60]),3.0*se_total_constantshift_r([46:53,55:60]),'^','Color',shift300_color,'MarkerSize',ms,...
    'MarkerFaceColor',shift300_color,'CapSize',capsize,'LineWidth',0.5);
plot(9,mean_average_constantshift_r(54),'^','Color',shift300_color,'MarkerSize',ms,'LineWidth',0.5);
ax=gca;
ax.XLim = [-1,0.5+T+Tw];
ax.YLim = [-20,50];
ax.XTick=[0 14 21 28];
ax.YTick=[0 20 40];
ax.YTickLabel=[0 .2 .4];
ax.FontSize=9;
% xlabel ('Day','FontSize',axfontSize/1.5);
ylabel ({'Pitch change';'(semitone)'},'FontSize',9);
set(inset,'Box','off');

% Save figure 2 as pdf.
set(gcf, 'PaperUnits', 'inches')
set(gcf,'PaperPosition',[-1 -0.2 13 4]);
set(gcf,'PaperSize',[11 3.8]);
saveas(gcf,'../results/Fitting','pdf');


%% Figure 3. Prediction.
figure
h(1) = subplot(2,3,1);
hold on;
h(2) = subplot(2,3,2);
hold on;
h(3) = subplot(2,3,3);
hold on;
h(4) = subplot(2,3,4);
hold on;
h(5) = subplot(2,3,5);
hold on;
h(6) = subplot(2,3,6);
hold on;

FigureRatio2 = [4 3 1];

axes(h(1));
shade_edge_std_constantshift_up1 = std_constantshift_average(1:(T+1),1)/Z+bound_std_constantshift(1:(T+1),1);
shade_edge_std_constantshift_down1 = std_constantshift_average(1:(T+1),1)/Z-bound_std_constantshift(1:(T+1),1);
plot(0:T,std_constantshift_average(1:(T+1),1)/Z,':','Color',shift50_color,'LineWidth',2);
fill([0:T,fliplr(0:T)],[shade_edge_std_constantshift_up1',fliplr(shade_edge_std_constantshift_down1')],shift50_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar(0:14,std_50_mean_std(1:15,1),std_50_mean_std(1:15,2),'o','Color',shift50_color,'MarkerSize',6,...
    'CapSize',capsize,'LineWidth',1);
ax=gca;
pbaspect(FigureRatio2)
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,15];
ax.XTick=[0 7 14];
ax.YLim=[40,120];
ax.YTick=[50 100];
ax.YTickLabel=[0.5 1.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for 0.5 semitone shift'},'FontSize',axfontSize);

axes(h(2));
shade_edge_std_constantshift_up2 = std_constantshift_average((T+2):2*(T+1),1)/Z+bound_std_constantshift((T+2):2*(T+1),1);
shade_edge_std_constantshift_down2 = std_constantshift_average((T+2):2*(T+1),1)/Z-bound_std_constantshift((T+2):2*(T+1),1);
plot(0:T,std_constantshift_average((T+2):2*(T+1),1)/Z,':','Color',shift100_color,'LineWidth',2);
fill([0:T,fliplr(0:T)],[shade_edge_std_constantshift_up2',fliplr(shade_edge_std_constantshift_down2')],shift100_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar(0:14,std_100_mean_std(1:15,1),std_100_mean_std(1:15,2),'s','Color',shift100_color,'MarkerSize',6,...
    'CapSize',capsize,'LineWidth',1);
ax=gca;
pbaspect(FigureRatio2)
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,15];
ax.XTick=[0 7 14];
ax.YLim=[40,120];
ax.YTick=[50 100];
ax.YTickLabel=[0.5 1.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for 1 semitone shift'},'FontSize',axfontSize);

axes(h(3));
shade_edge_std_constantshift_up3 = std_constantshift_average(2*(T+1)+1:3*(T+1),1)/Z+bound_std_constantshift(2*(T+1)+1:3*(T+1),1);
shade_edge_std_constantshift_down3 = std_constantshift_average(2*(T+1)+1:3*(T+1),1)/Z-bound_std_constantshift(2*(T+1)+1:3*(T+1),1);
plot(0:T,std_constantshift_average(2*(T+1)+1:3*(T+1),1)/Z,':','Color',shift150_color,'LineWidth',2);
fill([0:T,fliplr(0:T)],[shade_edge_std_constantshift_up3',fliplr(shade_edge_std_constantshift_down3')],shift150_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar(0:14,std_150_mean_std(1:15,1),std_150_mean_std(1:15,2),'d','Color',shift150_color,'MarkerSize',6,...
    'CapSize',capsize,'LineWidth',1);
ax=gca;
pbaspect(FigureRatio2)
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,15];
ax.XTick=[0 7 14];
ax.YLim=[40,120];
ax.YTick=[50 100];
ax.YTickLabel=[0.5 1.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for 1.5 semitone shift'},'FontSize',axfontSize);

axes(h(4));
shade_edge_std_constantshift_up4 = std_constantshift_average(3*(T+1)+1:4*(T+1),1)/Z+bound_std_constantshift(3*(T+1)+1:4*(T+1),1);
shade_edge_std_constantshift_down4 = std_constantshift_average(3*(T+1)+1:4*(T+1),1)/Z-bound_std_constantshift(3*(T+1)+1:4*(T+1),1);
plot(0:T,std_constantshift_average(3*(T+1)+1:4*(T+1),1)/Z,':','Color',shift300_color,'LineWidth',2);
fill([0:T,fliplr(0:T)],[shade_edge_std_constantshift_up4',fliplr(shade_edge_std_constantshift_down4')],shift300_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar([0:7,9:14],std_300_mean_std([0:7,9:14]+1,1),std_300_mean_std([0:7,9:14]+1,2),'^','Color',shift300_color,...
    'CapSize',capsize,'MarkerSize',6,'LineWidth',1);
plot(8,std_300_mean_std(9,1),'^','Color',shift300_color,'MarkerSize',6);
ax=gca;
pbaspect(FigureRatio2)
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,15];
ax.XTick=[0 7 14];
ax.YLim=[40,120];
ax.YTick=[50 100];
ax.YTickLabel=[0.5 1.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for 3 semitone shift'},'FontSize',axfontSize);

axes(h(5));
shade_edge_std_staircase_up = std_staircase_average(1:1+Ts)/Z+bound_std_staircase;
shade_edge_std_staircase_down = std_staircase_average(1:1+Ts)/Z-bound_std_staircase;
plot(0:Ts,std_staircase_average(1:1+Ts)/Z,':','Color',shiftStair_color,'LineWidth',2);
fill([0:Ts,fliplr(0:Ts)],[shade_edge_std_staircase_up',fliplr(shade_edge_std_staircase_down')],shiftStair_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar([1:39,41:43]-1,std_stair_mean_std([1:39,41:43],1),std_stair_mean_std([1:39,41:43],2),'v','Color',shiftStair_color,...
    'MarkerSize',6,'CapSize',capsize,'LineWidth',1);
plot([40,44:48]-1,std_stair_mean_std([40,44:48],1),'v','Color',shiftStair_color,'MarkerSize',6);
for ii = 3:8
    plot((ii-1)*6+1:ii*6,ii*35*ones(6,1),':','Color',[0 0 0],'LineWidth',2);
end
ax=gca;
pbaspect(FigureRatio2)
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,49];
ax.XTick=[0 12 24 36 48];
ax.YLim=[40,300];
ax.YTick=[100 200 300];
ax.YTickLabel=[1.0 2.0 3.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for staircase shift'},'FontSize',axfontSize);

axes(h(6));
shade_edge_d47_up = d47_distribution_average/Z+bound_d47_distribution;
shade_edge_d47_down = d47_distribution_average/Z-bound_d47_distribution;
histnorm(d47_distribution,sqrt(length(d47_distribution)));
set(get(gca,'child'),'FaceColor','none','EdgeColor',baseline_color,'LineWidth',1);
plot(-L:l:L,d47_distribution_average/Z,':','Color',baseline_color,'LineWidth',2);
fill([-L:l:L,fliplr(-L:l:L)],[shade_edge_d47_up,fliplr(shade_edge_d47_down)],baseline_color,'FaceAlpha',0.3,'EdgeColor','none');
ax=gca;
pbaspect(FigureRatio2)
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-600,600];
ax.XTick=[-400,-200,0,200,400];
ax.XTickLabel=[-4.0,-2.0,0,2.0,4.0];
ax.YLim=[0,10^-2];
ax.YTick=[0,10^-2];
xlabel ('Pitch sung by birds (semitone)','FontSize',axfontSize);ylabel ('Probability density','FontSize',axfontSize);

letter_x = -0.02;
letter_y = 1.18;

subplot(2,3,1)
text(letter_x,letter_y,'(A)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,2)
text(letter_x,letter_y,'(B)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,3)
text(letter_x,letter_y,'(C)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,4)
text(letter_x,letter_y,'(D)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,5)
text(letter_x,letter_y,'(E)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,6)
text(letter_x,letter_y,'(F)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)

% Save figure 3 as pdf.
set(gcf, 'PaperUnits', 'inches')
set(gcf,'PaperPosition',[-0.9 -0.2 13 6.6]);
set(gcf,'PaperSize',[11 6.3]);
saveas(gcf,'../results/Prediction','pdf');


%% Figure 4.
% Plots the landscape of the objective function with respect to
% 2 parameters given the other 4 parameters are fixed.
figure
h(1) = subplot(1,3,1);
h(2) = subplot(1,3,2);
h(3) = subplot(1,3,3);

label_fontsize = 16;

axes(h(1))
load('../variables/objective_function_value_1_new.mat');
imagesc(gamma1,alpha1,log10(objective_function_value_1));
hold;
scatter(5,0.34,'k+');
xlabel('$\gamma_{1}$ (semitone)','Interpreter','LaTex','FontSize',label_fontsize);ylabel('$\alpha_{1}$','Interpreter','LaTex','FontSize',label_fontsize);
colormap(flipud(gray))
set(gca,'YDir','normal');
colorbar;
pbaspect([5 3 1]);
ax = gca;
ax.XLim = [2 100];
ax.XTick = [20 60 100];
ax.XTickLabel = [0.2 0.6 1.0];
ax.YTick = [0.2 1.0 2.0];
ax.FontSize = label_fontsize;
hold;

axes(h(2))
load('../variables/objective_function_value_2_new.mat');
imagesc(gamma2,alpha2,log10(objective_function_value_2));
hold;
scatter(18,0.21,'k+');
xlabel('$\gamma_{2}$ (semitone)','Interpreter','LaTex','FontSize',label_fontsize);ylabel('$\alpha_{2}$','Interpreter','LaTex','FontSize',label_fontsize);
colormap(flipud(gray))
set(gca,'YDir','normal');
colorbar;
pbaspect([5 3 1]);
ax = gca;
ax.XLim = [2 100];
ax.XTick = [20 60 100];
ax.XTickLabel = [0.2 0.6 1.0];
ax.YTick = [0.2 1.0 2.0];
ax.FontSize = label_fontsize;
hold;

axes(h(3))
load('../variables/objective_function_value_k_new.mat');
imagesc(gammak,alphak,log10(abs(objective_function_value_k)));
hold;
scatter(28,1.73,'k+');
xlabel('$\gamma_{\textrm{k}}$ (semitone)','Interpreter','LaTex','FontSize',label_fontsize);ylabel('$\alpha_{\textrm{k}}$','Interpreter','LaTex','FontSize',label_fontsize);
colormap(flipud(gray))
set(gca,'YDir','normal');
colorbar;
pbaspect([5 3 1]);
ax = gca;
ax.XLim = [2 100];
ax.XTick = [20 60 100];
ax.XTickLabel = [0.2 0.6 1.0];
ax.YTick = [0.2 1.0 2.0];
ax.FontSize = label_fontsize;
hold;

subplot(1,3,1)
text(-0.01,1.3,'(A)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(1,3,2)
text(-0.02,1.3,'(B)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(1,3,3)
text(-0.02,1.3,'(C)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)

% Save figure 4 as pdf.
set(gcf, 'PaperUnits', 'inches')
set(gcf,'PaperPosition',[-1 -0.3 13 3]);
set(gcf,'PaperSize',[11 2.3]);
saveas(gcf,'../results/Figure_parameterSpace','pdf');


%% Figure 5. Power law model.
load('../variables/mean_std_on_curve_logScale_powerlaw.mat');
load('../variables/Gaussian_fit.mat');
bound_baseline_distribution = sqrt(abs(baseline_distribution_square/Z-(baseline_distribution_average/Z).^2));
bound_mean_constantshift_r = sqrt(abs(mean_constantshift_r_square/Z-(mean_constantshift_r_average/Z).^2));
bound_mean_staircase = sqrt(abs(mean_staircase_square/Z-(mean_staircase_average/Z).^2));
bound_d47_distribution = sqrt(abs(d47_distribution_square/Z-(d47_distribution_average/Z).^2));
bound_std_constantshift = sqrt(abs(std_constantshift_square/Z-(std_constantshift_average/Z).^2));
bound_std_staircase = sqrt(abs(std_staircase_square/Z-(std_staircase_average/Z).^2));

figureRatio = [5 3 1];
figure
h(1) = subplot(2,3,1);
hold on;
h(2) = subplot(2,3,2);
hold on;
h(3) = subplot(2,3,3);
hold on;
h(4) = subplot(2,3,4);
hold on;
h(5) = subplot(2,3,5);
hold on;
h(6) = subplot(2,3,6);
hold on;

axes(h(1));
plot(0:T+Tw,mean_constantshift_r_average(1:(T+Tw+1))/Z,'Color',shift50_color,'LineWidth',2);
plot(0:T+Tw,mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z,'Color',shift100_color,'LineWidth',2);
plot(0:T+Tw,mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z,'Color',shift150_color,'LineWidth',2);
plot(0:T+Tw,mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z,'Color',shift300_color,'LineWidth',2);

shade_edge_constantshift_up1 = mean_constantshift_r_average(1:(T+Tw+1))/Z+bound_mean_constantshift_r(1:(T+Tw+1));
shade_edge_constantshift_down1 = mean_constantshift_r_average(1:(T+Tw+1))/Z-bound_mean_constantshift_r(1:(T+Tw+1));
shade_edge_constantshift_up2 = mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z+bound_mean_constantshift_r((T+Tw+2):2*(T+Tw+1));
shade_edge_constantshift_down2 = mean_constantshift_r_average((T+Tw+2):2*(T+Tw+1))/Z-bound_mean_constantshift_r((T+Tw+2):2*(T+Tw+1));
shade_edge_constantshift_up3 = mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z+bound_mean_constantshift_r(2*(T+Tw+1)+1:3*(T+Tw+1));
shade_edge_constantshift_down3 = mean_constantshift_r_average(2*(T+Tw+1)+1:3*(T+Tw+1))/Z-bound_mean_constantshift_r(2*(T+Tw+1)+1:3*(T+Tw+1));
shade_edge_constantshift_up4 = mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z+bound_mean_constantshift_r(3*(T+Tw+1)+1:4*(T+Tw+1));
shade_edge_constantshift_down4 = mean_constantshift_r_average(3*(T+Tw+1)+1:4*(T+Tw+1))/Z-bound_mean_constantshift_r(3*(T+Tw+1)+1:4*(T+Tw+1));
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up1',fliplr(shade_edge_constantshift_down1')],shift50_color,'FaceAlpha',0.3,'EdgeColor','none');
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up2',fliplr(shade_edge_constantshift_down2')],shift100_color,'FaceAlpha',0.3,'EdgeColor','none');
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up3',fliplr(shade_edge_constantshift_down3')],shift150_color,'FaceAlpha',0.3,'EdgeColor','none');
fill([0:T+Tw,fliplr(0:T+Tw)],[shade_edge_constantshift_up4',fliplr(shade_edge_constantshift_down4')],shift300_color,'FaceAlpha',0.3,'EdgeColor','none');

errorbar(0:14,mean_average_constantshift_r(1:15),se_total_constantshift_r(1:15),'o','Color',shift50_color,'MarkerSize',6,...
    'MarkerFaceColor',shift50_color,'CapSize',capsize,'LineWidth',1);
errorbar(0:14,mean_average_constantshift_r(16:30),se_total_constantshift_r(16:30),'s','Color',shift100_color,'MarkerSize',6,...
    'MarkerFaceColor',shift100_color,'CapSize',capsize,'LineWidth',1);
errorbar(0:14,mean_average_constantshift_r(31:45),se_total_constantshift_r(31:45),'d','Color',shift150_color,'MarkerSize',6,...
    'MarkerFaceColor',shift150_color,'CapSize',capsize,'LineWidth',1);
errorbar([0:8,10:14],mean_average_constantshift_r([46:53,55:60]),se_total_constantshift_r([46:53,55:60]),'^','Color',shift300_color,'MarkerSize',6,...
    'MarkerFaceColor',shift300_color,'CapSize',capsize,'LineWidth',1);
plot(9,mean_average_constantshift_r(54),'^','Color',shift300_color,'MarkerSize',6,'LineWidth',1);
ax=gca;
pbaspect(figureRatio);
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,1+T+Tw];
ax.XTick=[0 7 14 21 28];
ax.YLim=[-10,100];
ax.YTick=[0 50 100];
xlabel('Day','FontSize',axfontSize);ylabel ('Pitch adaptation (in percentage)','FontSize',axfontSize);

axes(h(2));
shade_edge_staircase_up = abs(mean_staircase_average(1:1+Ts))/Z+bound_mean_staircase;
shade_edge_staircase_down = abs(mean_staircase_average(1:1+Ts))/Z-bound_mean_staircase;
plot(0:Ts,abs(mean_staircase_average(1:1+Ts))/Z,'Color',shiftStair_color,'LineWidth',2);
fill([0:Ts,fliplr(0:Ts)],[shade_edge_staircase_up',fliplr(shade_edge_staircase_down')],shiftStair_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar([0:38,40:42],mean_average_staircase([1:39,41:43]),se_total_staircase([1:39,41:43]),'v','Color',shiftStair_color,'MarkerSize',6,...
    'MarkerFaceColor',shiftStair_color,'CapSize',capsize,'LineWidth',1);
plot([39,43:47],mean_average_staircase([40,44:48]),'v','Color',shiftStair_color,'MarkerSize',6);
for ii = 1:8
    plot((ii-1)*6+1:ii*6,ii*35*ones(6,1),':','Color',[0 0 0],'LineWidth',2);
end
ax=gca;
pbaspect(figureRatio);
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,49];
ax.XTick=[0 12 24 36 48];
ax.YLim=[-10,300];
ax.YTick=[0 100 200 300];
ax.YTickLabel=[0 1.0 2.0 3.0];
xlabel ('Day','FontSize',axfontSize);ylabel ('Pitch adaptation (semitone)','FontSize',axfontSize);

axes(h(3));
shade_edge_baseline_up = baseline_distribution_average/Z+bound_baseline_distribution;
shade_edge_baseline_down = baseline_distribution_average/Z-0.4*bound_baseline_distribution;
histnorm(baseline_distribution,sqrt(length(baseline_distribution)));
h1 = findobj(gca,'Type','patch');
h1.EdgeColor = baseline_color;
h1.LineWidth = axlineWidth;
plot(-L:l:L,Gaussian_fit,'Color',[0.5 0.5 0.5],'LineWidth',1);
plot(-L:l:L,baseline_distribution_average/Z,'Color',baseline_color,'LineWidth',2);
fill([-L:l:L,fliplr(-L:l:L)],[shade_edge_baseline_up,fliplr(shade_edge_baseline_down)],baseline_color,'FaceAlpha',0.3,'EdgeColor','none');
ax=gca;
pbaspect(figureRatio);
ax.YScale='log';
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-400,400];
ax.XTick=[-400,-200,0,200,400];
ax.XTickLabel=[-4.0,-2.0,0,2.0,4.0];
ax.YLim=[10^-7,10^-1];
ax.YTick=[10^-6,10^-4,10^-2];
xlabel ('Pitch sung by birds (semitone)','FontSize',axfontSize);ylabel ('Probability density','FontSize',axfontSize);

axes(h(4));
shade_edge_std_constantshift_up3 = std_constantshift_average(2*(T+1)+1:3*(T+1),1)/Z+bound_std_constantshift(2*(T+1)+1:3*(T+1),1);
shade_edge_std_constantshift_down3 = std_constantshift_average(2*(T+1)+1:3*(T+1),1)/Z-bound_std_constantshift(2*(T+1)+1:3*(T+1),1);
plot(0:T,std_constantshift_average(2*(T+1)+1:3*(T+1),1)/Z,':','Color',shift150_color,'LineWidth',2);
fill([0:T,fliplr(0:T)],[shade_edge_std_constantshift_up3',fliplr(shade_edge_std_constantshift_down3')],shift150_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar(0:14,std_150_mean_std(1:15,1),std_150_mean_std(1:15,2),'d','Color',shift150_color,'MarkerSize',6,...
    'CapSize',capsize,'LineWidth',1);
ax=gca;
pbaspect(figureRatio);
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,15];
ax.XTick=[0 7 14];
ax.YLim=[40,120];
ax.YTick=[50 100];
ax.YTickLabel=[0.5 1.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for 1.5 semitone shift'},'FontSize',axfontSize);

axes(h(5));
shade_edge_std_staircase_up = std_staircase_average(1:1+Ts)/Z+bound_std_staircase;
shade_edge_std_staircase_down = std_staircase_average(1:1+Ts)/Z-bound_std_staircase;
plot(0:Ts,std_staircase_average(1:1+Ts)/Z,':','Color',shiftStair_color,'LineWidth',2);
fill([0:Ts,fliplr(0:Ts)],[shade_edge_std_staircase_up',fliplr(shade_edge_std_staircase_down')],shiftStair_color,'FaceAlpha',0.3,'EdgeColor','none');
errorbar([1:39,41:43]-1,std_stair_mean_std([1:39,41:43],1),std_stair_mean_std([1:39,41:43],2),'v','Color',shiftStair_color,...
    'MarkerSize',6,'CapSize',capsize,'LineWidth',1);
plot([40,44:48]-1,std_stair_mean_std([40,44:48],1),'v','Color',shiftStair_color,'MarkerSize',6);
for ii = 3:8
    plot((ii-1)*6+1:ii*6,ii*35*ones(6,1),':','Color',[0 0 0],'LineWidth',2);
end
ax=gca;
pbaspect(figureRatio);
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-1,49];
ax.XTick=[0 12 24 36 48];
ax.YLim=[40,300];
ax.YTick=[100 200 300];
ax.YTickLabel=[1.0 2.0 3.0];
xlabel ('Day','FontSize',axfontSize);ylabel ({'Standard deviation (semitone)';'for staircase shift'},'FontSize',axfontSize);

axes(h(6));
shade_edge_d47_up = d47_distribution_average/Z+bound_d47_distribution;
shade_edge_d47_down = d47_distribution_average/Z-bound_d47_distribution;
histnorm(d47_distribution,sqrt(length(d47_distribution)));
set(get(gca,'child'),'FaceColor','none','EdgeColor',baseline_color,'LineWidth',1);
plot(-L:l:L,d47_distribution_average/Z,':','Color',baseline_color,'LineWidth',2);
fill([-L:l:L,fliplr(-L:l:L)],[shade_edge_d47_up,fliplr(shade_edge_d47_down)],baseline_color,'FaceAlpha',0.3,'EdgeColor','none');
ax=gca;
pbaspect(figureRatio);
ax.LineWidth=axlineWidth;
ax.FontSize=axfontSize;
ax.XLim=[-600,600];
ax.XTick=[-400,-200,0,200,400];
ax.XTickLabel=[-4.0,-2.0,0,2.0,4.0];
ax.YLim=[0,10^-2];
ax.YTick=[0,10^-2];
xlabel ('Pitch sung by birds (semitone)','FontSize',axfontSize);ylabel ('Probability density','FontSize',axfontSize);

letter_x = -0.02;
letter_y = 1.25;

subplot(2,3,1)
text(letter_x,letter_y,'(A)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,2)
text(letter_x,letter_y,'(B)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,3)
text(letter_x,letter_y,'(C)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,4)
text(letter_x,letter_y,'(D)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,5)
text(letter_x,letter_y,'(E)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)
subplot(2,3,6)
text(letter_x,letter_y,'(F)','Units', 'Normalized', 'VerticalAlignment', 'Top','FontWeight','bold','FontSize',12)

% Save figure 5 as pdf.
set(gcf, 'PaperUnits', 'inches')
set(gcf,'PaperPosition',[-0.9 -0.3 13 5.9]);
set(gcf,'PaperSize',[11 5.5]);
saveas(gcf,'../results/Figure_powerlaw','pdf');

end