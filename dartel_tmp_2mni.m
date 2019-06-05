mni_mat =load('/home/antogeo/Desktop/test/Dartel_tmp/Template_6_2mni.mat')
P='/home/antogeo/data/ICA/Alice_Yorgos_Jitka/tmps_dartel/Template_6.nii';
M = mni_mat.mni.affine;

Nii = nifti(P);
Nii.mat = mni.affine;
Nii.mat_intent = 4;
create(Nii);