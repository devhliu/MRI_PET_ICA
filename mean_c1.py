import os
import os.path as op
import pypet
from nipype.interfaces.fsl.maths import MeanImage
from nipype.interfaces.fsl.utils import Merge
from nipype.interfaces.spm import Smooth
from glob import glob
import nipype.pipeline.engine as pe
import nibabel as nib


def mni_tmplt(db_path, gm_list):
    merger = pe.Node(Merge(), name='merger')
    # merger = Merge()
    # merger.inputs.merged_file = os.path.join(db_path, 'extras', 'merged.nii')
    merger.inputs.in_files = gm_list
    merger.inputs.dimension = 't'
    merger.inputs.output_type = 'NIFTI'
    # merger.run()
    mean = pe.Node(MeanImage(), name='mean')
    mean.inputs.output_type = 'NIFTI'
    sm = pe.Node(Smooth(), name='sm')
    sm.inputs.fwhm = 8
    # sm.inputs.output_type = 'NIFTI'
    mean.inputs.out_file = os.path.join(db_path, 'extra', 'mean_wc1.nii')

    ppln = pe.Workflow(name='ppln')
    ppln.connect([(merger, mean,  [('merged_file', 'in_file')]),
                  (mean, sm, [('out_file', 'in_files')]),
                  ])
    ppln.run()

    img = nib.load(os.path.join(db_path, 'extra', 'mean_wc1.nii'))
    scld_vox = (img.get_data() / img.get_data().max())
    new_img = nib.Nifti1Image(scld_vox, img.affine, img.header)
    nib.save(new_img, os.path.join(db_path, 'extra', 'smean_wc1.nii'))


if os.uname()[1] == 'antogeo-XPS':
    db_path = '/home/antogeo/data/ICA_PET/dartel/Alice_Yorgos_Jitka'
elif os.uname()[1] == 'comameth':
    db_path = '/home/coma_meth/Documents/ICA_PET/dartel/Alice_Yorgos_Jitka'
elif os.uname()[1] in ['mia.local', 'mia']:
    db_path = '/home/coma_meth/Documents/ICA_PET/dartel/Alice_Yorgos_Jitka'

groups = sorted([op.basename(x) for x in glob(
                   op.join(db_path, 'subjects', '*')) if op.isdir(x)])

gm_list = []
i = 0
for group in groups:
    f_subjs = os.listdir(op.join(db_path, 'subjects', group))
    for subj in f_subjs:
        s_path = op.join(db_path, 'subjects', group, subj)
        files = [op.basename(x) for x in glob(
                 op.join(s_path, 'uni_seg', 'wc1*')) if not op.isdir(x)]
        for file in files:
            print(file)
            # print(i)
            # i = i + 1
            gm_list.append(op.join(s_path, 'uni_seg', file))


mni_tmplt(db_path, gm_list)
