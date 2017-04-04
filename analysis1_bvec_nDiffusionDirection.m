%% Check #_diffusion_angle used for DWI: Season 3 and 4

clear; clc; close all;

cd bvec/S34_FB_BF
allFiles = dir('./*bvec');
allNames = {allFiles.name};

nbvecs_BF = zeros(length(allNames),1);
for ii = 1:length(allNames)
    bvecs = load(allNames{ii});
    nbvecs_BF(ii) = size(bvecs,2);
end
cd ../..

cd bvec/S34_FB_IN1
allFiles = dir('./*bvec');
allNames = {allFiles.name};

nbvecs_IN1 = zeros(length(allNames),1);
for ii = 1:length(allNames)
    bvecs = load(allNames{ii});
    nbvecs_IN1(ii) = size(bvecs,2);
end
cd ../..

cd bvec/S34_FB_IN2
allFiles = dir('./*bvec');
allNames = {allFiles.name};

nbvecs_IN2 = zeros(length(allNames),1);
for ii = 1:length(allNames)
    bvecs = load(allNames{ii});
    nbvecs_IN2(ii) = size(bvecs,2);
end
cd ../..

cd bvec/S34_FB_Post
allFiles = dir('./*bvec');
allNames = {allFiles.name};

nbvecs_Post = zeros(length(allNames),1);
for ii = 1:length(allNames)
    bvecs = load(allNames{ii});
    nbvecs_Post(ii) = size(bvecs,2);
end
cd ../..

% summary table: row=subject, col=session
nbvecs_tabl = zeros(length(allNames),4);
nbvecs_tabl(:,1) = nbvecs_BF;
nbvecs_tabl(:,2) = nbvecs_IN1;
nbvecs_tabl(:,3) = nbvecs_IN2;
nbvecs_tabl(:,4) = nbvecs_Post;


%% Result
% S34_FB_BF     26 bvec: subj 1,2,3,4 / 31 bvec: all other
% S34_FB_IN1    31 bvec: all
% S34_FB_IN2    31 bvec: all
% S34_FB_Post   31 bvec: all


cd bvec/S34_FB_BF
allFiles = dir('./*bvec');
allNames = {allFiles.name};

bvec26 = load(allNames{1});
figure('position',[100 100 500 500]);
plot3(bvec26(1,:),bvec26(2,:),bvec26(3,:),'*r');
title('# Diffusion Gradient Orientation = 25');
axis([-1 1 -1 1 -1 1]); axis vis3d; rotate3d

bvec31 = load(allNames{5});
figure('position',[100 100 500 500]);
plot3(bvec31(1,:),bvec31(2,:),bvec31(3,:),'*r');
title('# Diffusion Gradient Orientation = 30');
axis([-1 1 -1 1 -1 1]); axis vis3d; rotate3d
cd ../..
