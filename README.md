# DTI process and analysis

This section is for those who deal with Diffusion weighted MR images.

DTI preprocess (bash script) requires FSL libraries. Please download and install FSL (https://fsl.fmrib.ox.ac.uk/fsldownloads/fsldownloadmain.html).

DTI analysis (matlab script) requires a library to read and write NIFTI files. You can download the library from https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image .

Pipeline:
- process_DTI.sh
- TBSS
  1) tbss_1_preproc *nii.gz
  2) tbss_2_reg -T
  3) tbss_3_postreg -S
  4) tbss_4_prestats 0.2
  5) other optional processes
- analysisX_XXXX.m
