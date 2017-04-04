clear;clc;close all;

cd C:\Users\Ikbeom\Desktop\DTI_2015\FB_S3456_Processing_FMRIB_0.2\vol_wholeGroup_FA

% Load tstat Data
cd BF_In1
tmp1=load_nii('ptbss_tfce_corrp_tstat2.nii.gz');
BF_In1_tfce_2=tmp1.img;
cd ..

cd BF_In2
tmp1=load_nii('ptbss_tfce_corrp_tstat2.nii.gz');
BF_In2_tfce_2=tmp1.img;
cd ..

cd BF_Post2
tmp1=load_nii('ptbss_tfce_corrp_tstat2.nii.gz');
BF_Post2_tfce_2=tmp1.img;
cd ..

% Find Threshold for p-value (voxel w/ top 5% change)
a2=BF_In1_tfce_2(BF_In1_tfce_2>0);
a2_sorted=sort(a2,1,'descend');
thresh=a2_sorted(round(length(a2)*0.05)); % define "Deviated" for Top 3% change

% Find Deviated Region (nDeviated=2404, WMskeleton=48092)
idx_BF_In1=find(BF_In1_tfce_2 > thresh);
idx_BF_In2=find(BF_In2_tfce_2 > thresh);
idx_BF_Post2=find(BF_Post2_tfce_2 > thresh);
% union of BF_In1 & BF_In2 & BF_Post2
alteredRegion = union(idx_BF_In1,idx_BF_In2);
alteredRegion = union(alteredRegion,idx_BF_Post2);

cd C:\Users\Ikbeom\Desktop\DTI_2015\Analysis_divide3_PLA
save('alteredRegion_wholeGroup0_05','alteredRegion'); % save(FILENAME, VAR)
