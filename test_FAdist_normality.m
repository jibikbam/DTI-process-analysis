clear; close all; clc;

cd all_FA
A = load_nii('vol0000.nii.gz'); A = A.img; A = A(:);
B = load_nii('vol0001.nii.gz'); B = B.img; B = B(:);
C = load_nii('vol0002.nii.gz'); C = C.img; C = C(:);
cd ..

AA = find(A>0);

load alteredRegion_wholeGroup0_05.mat
% idx = alteredRegion;
idx1 = load_nii('mean_FA_skeleton_mask_subject.nii.gz'); idx1=idx1.img; idx1=find(idx1>0);

A_ind = A(idx1);
B_ind = B(idx1);
C_ind = C(idx1);

figure
subplot(1,3,1); hist(A_ind, 40);
subplot(1,3,2); hist(B_ind, 40);
title('Distribution of FA in WM Tract -- Test Normality'); ylabel('Count'); xlabel('FA');
subplot(1,3,3); hist(C_ind, 40);

