l = 1;L = 1000;
input_para = [1.676399,24.187500,0.347892,7.403856,0.282438,12.084570];
distribution_type = 'stable';

% generate theoretical variables
[prior1d_baseline,prior1d_50,prior1d_100,prior1d_150,prior1d_300,...
    prior1d_stair,mean_const,mean_stair,std_const,std_stair] ...
    = songbird_single_timescale(l,L,input_para,distribution_type);

% load the data
load('../data/data_for_figures.mat');

% color code for the curves 
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

% baseline
figure;hold;
histnorm(baseline_distribution,sqrt(length(baseline_distribution)));
h = findobj(gca,'Type','patch');
h.EdgeColor = baseline_color;
plot(-L:l:L,prior1d_baseline);
ax=gca;
axis square;
ax.YScale='log';
ax.XLim=[-400,400];
xlabel ('Pitch sung by birds (cent)');
ylabel ('Probability density');
hold;

% constant shift
figure;hold;
errorbar(0:14,mean_average_constantshift_r(1:15),se_total_constantshift_r(1:15),'o','Color',shift50_color);
errorbar(0:14,mean_average_constantshift_r(16:30),se_total_constantshift_r(16:30),'s','Color',shift100_color);
errorbar(0:14,mean_average_constantshift_r(31:45),se_total_constantshift_r(31:45),'d','Color',shift150_color);
errorbar([0:8,10:14],mean_average_constantshift_r([46:53,55:60]),se_total_constantshift_r([46:53,55:60]),'^','Color',shift300_color);
plot(9,mean_average_constantshift_r(54),'^','Color',shift300_color);
plot(0:14,mean_const(:,1)*100./50.,'Color',shift50_color);
plot(0:14,mean_const(:,2)*100./100.,'Color',shift100_color);
plot(0:14,mean_const(:,3)*100./150.,'Color',shift150_color);
plot(0:14,mean_const(:,4)*100./300.,'Color',shift300_color);
xlabel('Day');
ylabel ('Pitch change (in percentage)');
hold;

% staircase shift
figure;hold;
errorbar([0:38,40:42],mean_average_staircase([1:39,41:43]),se_total_staircase([1:39,41:43]),'v','Color',shiftStair_color);
plot([39,43:47],mean_average_staircase([40,44:48]),'v','Color',shiftStair_color);
plot(0:48,mean_stair(:,1),'Color',shiftStair_color);
xlabel ('Day');
ylabel ('Pitch change (cent)');
hold;