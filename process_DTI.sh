#!/bin/bash
# DTI PREPROCESSING SCRIPT by Ikbeom Jang
# Feb 13, 2017
# 1. Brain extraction
# 2. Eddy current & Motion correction
# 3. DTI estimation
#
# Should run this script where it contains all subject folders (CIC_Pre*, ISDH_Pre*)


# INPUT: 1426 DICOM images (iXXXXXXX.MRDC.X)
# OUTPUT: pre-processed FA image & processsed folder

DIR=`pwd`

for i in `find ./ -maxdepth 1 -mindepth 1 -type d`
   do
	cd $i
        echo $i

	## Dicom to NIFTI (output: *1001.bval, *1001.bvec, *1001.nii.gz)
	dcm2nii i*
	mkdir DICOM
	mv i* DICOM

	mv *1001.nii.gz all_my_images.nii.gz
	mv *1001.bval mybval.bval
	mv *1001.bvec mybvec.bvec
	scp $DIR/index.txt .
	scp $DIR/acqparams.txt .
	
        ## Brain extraction (output: b0_brain.nii.gz, b0_brain_mask.nii.gz)
        fslsplit all_my_images.nii.gz -t  # extract b0 (vol0000.nii.gz)
	echo Extracting brain based on b0 image ...
        bet vol0000.nii.gz b0_brain -f 0.15 -m -R  # smaller values give larger brain outline

        ## Eddy current and Motion correction (eddy_openmp: 2016 Aug updated)
	echo Eddy current and motion correction using eddy ...
        eddy_openmp --imain=all_my_images.nii.gz --mask=b0_brain_mask.nii.gz --acqp=acqparams.txt --index=index.txt --bvecs=mybvec.bvec --bvals=mybval.bval --repol --out=eddy_corrected

	## Brain extraction (output: corrected_brain.nii.gz, corrected_mask.nii.gz)
	echo Extracting brain based on eddy corrected image ...
	bet eddy_corrected.nii.gz eddy_corrected_brain -f 0.15 -m -R	

        ## DTI estimation
	echo Estimating DTI images including FA, MD, L1, L2, L3, etc.
        dtifit -k eddy_corrected.nii.gz -m eddy_corrected_brain_mask.nii.gz -r mybvec.bvec -b mybval.bval -o ${PWD##*/}

	mkdir volumes
	mv vol*nii.gz volumes

        cp *_FA.* $DIR
        cd $DIR

done
