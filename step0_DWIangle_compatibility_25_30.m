%% Test if 25 angle DWI (S3) can be mutually used with 30 angle DWI (S456)
clear;clc;close;

CASE = 1;    % subj=1 or ctr=2

%% TEST FOR SUBJECTS
if CASE == 1
    % call idx for subject(WM skeleton)
    mask=load_nii('mean_FA_skeleton_mask_subject.nii.gz'); % ptbss_tfce_corrp_tstat2_whole_BF_In1.nii.gz / alteredRegion_wholeGroup0_03.mat
    mask=mask.img; mask = mask(:);
    idx= find(mask > 0);

    % make name lists
    allFiles = dir('all_FA/vol*');
    allNames = {allFiles.name};
    
    BF = allNames(1:length(allNames)/4);
    In1 = allNames(length(allNames)/4+1:length(allNames)/2);
    In2 = allNames(length(allNames)/2+1:length(allNames)/4*3);
    Post2 = allNames(length(allNames)/4*3+1:end);
    
    all = [BF; In1; In2; Post2]';
    
    
    %% Separate S3 (N=9, 25angle) from S4~6 (N=36, 30angle)
    % S3 vol# 1204, 1207, 1218, 1222, 1231, 1244, 201, 209, 302, 303
    S3 = all(1:10,:); % row 1~10 are S3 (see 'subjectInfo_grouping.xlsx')
    S456 = all(11:end,:); % row 11~45 are S4,5,6
    
    % calculate mean FA at each session on the mask for S3 subjects
    S3_BF = S3(:,1);
    S3_In1 = S3(:,2);
    S3_In2 = S3(:,3);
    S3_Post2 = S3(:,4);
    
    meanFA_inWMtract_S3 = zeros(length(S3_BF),4);
    for a = 1:length(S3_BF)
        name_A = S3_BF{a};
        name_B = S3_In1{a};
        name_C = S3_In2{a};
        name_D = S3_Post2{a};
        
        cd('all_FA')
        A_org = load_nii(name_A);   A=A_org.img; A=A(:);    
        B_org = load_nii(name_B);   B=B_org.img; B=B(:);
        C_org = load_nii(name_C);   C=C_org.img; C=C(:);
        D_org = load_nii(name_D);   D=D_org.img; D=D(:);
        cd ..
        
        A_ind = A(idx); B_ind = B(idx); C_ind = C(idx); D_ind = D(idx);
        
        meanFA_inWMtract_S3(a,1)=mean(A_ind(A_ind~=0));
        meanFA_inWMtract_S3(a,2)=mean(B_ind(B_ind~=0));
        meanFA_inWMtract_S3(a,3)=mean(C_ind(C_ind~=0));
        meanFA_inWMtract_S3(a,4)=mean(D_ind(D_ind~=0));
    end
    % result: meanFA_inWMtract_S3
    display(mean(meanFA_inWMtract_S3(:,1)),'S3_BF')
    display(mean(meanFA_inWMtract_S3(:,2)),'S3_In1')
    display(mean(meanFA_inWMtract_S3(:,3)),'S3_In2')
    display(mean(meanFA_inWMtract_S3(:,4)),'S3_Post')
    
    
    % calculate mean FA at each session on the mask for S4-6 subjects
    S456_BF = S456(:,1);
    S456_In1 = S456(:,2);
    S456_In2 = S456(:,3);
    S456_Post2 = S456(:,4);
    
    meanFA_inWMtract_S456 = zeros(length(S456_BF),4);
    for a = 1:length(S456_BF)
        name_A = S456_BF{a};
        name_B = S456_In1{a};
        name_C = S456_In2{a};
        name_D = S456_Post2{a};
        
        cd('all_FA')
        A_org = load_nii(name_A);   A=A_org.img; A=A(:);    
        B_org = load_nii(name_B);   B=B_org.img; B=B(:);
        C_org = load_nii(name_C);   C=C_org.img; C=C(:);
        D_org = load_nii(name_D);   D=D_org.img; D=D(:);
        cd ..
        
        A_ind = A(idx); B_ind = B(idx); C_ind = C(idx); D_ind = D(idx);
        
        meanFA_inWMtract_S456(a,1)=mean(A_ind(A_ind~=0));
        meanFA_inWMtract_S456(a,2)=mean(B_ind(B_ind~=0));
        meanFA_inWMtract_S456(a,3)=mean(C_ind(C_ind~=0));
        meanFA_inWMtract_S456(a,4)=mean(D_ind(D_ind~=0));
    end
    % result: meanFA_inWMtract_S456
    display(mean(meanFA_inWMtract_S456(:,1)),'S456_BF')
    display(mean(meanFA_inWMtract_S456(:,2)),'S456_In1')
    display(mean(meanFA_inWMtract_S456(:,3)),'S456_In2')
    display(mean(meanFA_inWMtract_S456(:,4)),'S456_Post')

    meanFA_subj = [meanFA_inWMtract_S3; meanFA_inWMtract_S456];
    save('meanFA_inWMtract_subj', 'meanFA_subj')
end


%% TEST FOR CONTROLS
if CASE == 2
    % call idx for controls (WM skeleton)
    mask2=load_nii('mean_FA_skeleton_mask_control.nii.gz');
    mask2=mask2.img; mask2 = mask2(:);
    idx2= find(mask2 > 0);

    % make name lists
    allFiles_ctr = dir('control_MD/vol*.nii.gz');
    allNames_ctr = {allFiles_ctr.name};
    CTR_BF = allNames_ctr(1:length(allNames_ctr)/2);
    CTR_Post = allNames_ctr(length(allNames_ctr)/2+1:end);

    meanFA_inWMtract_CTR = zeros(length(CTR_BF),2);
    for a = 1:length(CTR_BF)
        name_A = CTR_BF{a};
        name_B = CTR_Post{a};

        cd('control_MD')
        A_org = load_nii(name_A);   A=A_org.img; A=A(:);    
        B_org = load_nii(name_B);   B=B_org.img; B=B(:);
        cd ..

        A_ind = A(idx2); B_ind = B(idx2);

        meanFA_inWMtract_CTR(a,1)=mean(A_ind(A_ind~=0));
        meanFA_inWMtract_CTR(a,2)=mean(B_ind(B_ind~=0));
    end
    % result: meanFA_inWMtract_CTR
    display(mean(meanFA_inWMtract_CTR(:,1)),'CTR_BF')
    display(mean(meanFA_inWMtract_CTR(:,2)),'CTR_Post')

    meanMD_ctr = meanFA_inWMtract_CTR;
    save('meanMD_inWMtract_control', 'meanMD_ctr')
end

clear A A_ind A_org B B_ind B_org C C_ind C_org D D_ind D_org name_A name_B name_C name_D
