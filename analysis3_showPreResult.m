%% Step 4. Show trend of absolute FA / MD for all subject
% Preliminary result before finding alteredRegion.
clear;clc; %close all;

CASE = 1;    % subj=1 or ctr=2

%% RESULTS OF SUBJECTS
if CASE == 1
    load meanFA_inWMtract_subj.mat
    load meanMD_inWMtract_subj.mat
    FA_subj = mean(meanFA_subj); 
    MD_subj = mean(meanMD_subj);

    % FA: show results in errorbar (mean and CI(1*std))
    figure
    errorbar(FA_subj, std(meanFA_subj))
    set(gca,'XTick',1:4,'XTickLabel', {'Pre' 'In1' 'In2' 'Post'},'FontSize', 16)
    title('Means and Confidence Intervals of mean FA : FB(N=45)','FontSize',18);
    ylabel('FA', 'FontSize',18); axis([0.5 4.5 0.46 0.5]);
    hold on; plot(FA_subj, 'd');

    % MD: show results in errorbar (mean and CI(1*std))
    figure
    errorbar(MD_subj, std(meanMD_subj))
    set(gca,'XTick',1:4,'XTickLabel', {'Pre' 'In1' 'In2' 'Post'},'FontSize', 16)
    title('Means and Confidence Intervals of mean MD : FB(N=45)','FontSize',18);
    ylabel('MD', 'FontSize',18); axis([0.5 4.5 7.53*10^(-4) 8.15*10^(-4)]);
    hold on; plot(MD_subj, 'd');
end
% % show results in whisker plot (median and CI)
% figure
% boxplot(meanFA_subj, 'whisker', 2.0);
% hold on; plot(FA_subj, 'd');


%% RESULTS OF CONTROLS
if CASE == 2
    load meanFA_inWMtract_control.mat
    load meanMD_inWMtract_control.mat
    FA_ctr = mean(meanFA_ctr); 
    MD_ctr = mean(meanMD_ctr); 

    % FA: show results in errorbar (mean and CI(1*std))
    figure
    errorbar(FA_ctr, std(meanFA_ctr))
    set(gca,'XTick',1:2,'XTickLabel', {'Test' 'Retest'},'FontSize', 16)
    title('Means and Confidence Intervals of mean FA : CON(N=15)','FontSize',18);
    ylabel('mean FA', 'FontSize',18); axis([0.5 2.5 0.46 0.5]);
    hold on; plot(FA_ctr, 'd');

    % MD: show results in errorbar (mean and CI(1*std))
    figure
    errorbar(MD_ctr, std(meanMD_ctr))
    set(gca,'XTick',1:2,'XTickLabel', {'Test' 'Retest'},'FontSize', 16)
    title('Means and Confidence Intervals of mean MD : CON(N=15)','FontSize',18);
    ylabel('mean MD', 'FontSize',18); axis([0.5 2.5 7.53*10^(-4) 8.15*10^(-4)]);
    hold on; plot(MD_ctr, 'd');
end
% % show results in whisker plot (median and CI)
% figure
% boxplot(meanFA_ctr, 'whisker', 2.0);
% hold on; plot(FA_ctr, 'd');
