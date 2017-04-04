#!/bin/bash
# DTI PREPROCESSING
# Should run this where it contains all subject folders (CIC_Pre*, ISDH_Pre*)

# INPUT: 1426 DICOM images (iXXXXXXX.MRDC.X)
# OUTPUT: XX.bval, XX.bvec, XX.nii.gz

DIR=`pwd`

#for i in `find ./ -type d -maxdepth 1 -mindepth 1`
for i in `find ./ -maxdepth 1 -mindepth 1 -type d`
  do
     cd $i
     ## Dicom to NIFTI 
     dcm2nii i*
     # -> .bval, _original.bvec

     ## Motion correction by rotating b vector
     motion_correct_rotbvec *.nii.gz motion 0 *.bvec
     # -> motion_tmp0000~30.nii.gz -> motion.nii.gz & motion.ecclog, .bvec

     ## Eddy current and motion correction by most conventional method
     # : Eddy currents in the gradient coils induce (approximate) stretches and shears in the diffusion weighted images. These distortions are different for different gradient directions. Eddy Current Correction corrects for these distortions, and for simple head motion, using affine registration to a reference volume.
     eddy_correct *1001.nii.gz eddy 0
     # -> eddy_tmp0000~30.nii.gz -> eddy.nii.gz & eddy.ecclog

     ## Brain extraction
     bet eddy.nii.gz mask -f 0.15 -m -R
     # mask, mask_mask.nii.gz

     ## DTI estimation
     dtifit -k eddy.nii.gz -m mask_mask.nii.gz -r *.bvec -b *.bval -o ${PWD##*/}     
     # -> L1,L2,L3, FA,MD,MO,S0, V1,V2,V3.nii.gz
     
     cp *_FA.* $DIR
     cd $DIR
done

