% Main path
clc; clear;
m_path = '/home/coma_meth/dox/Pet_pain_threshold/';
subj_path = fullfile(m_path, 'subjects');
subjs = dir(subj_path);
subjs = {subjs(3: end).name}';

mask_path = fullfile(m_path, 'extras', 'masks');
masks = dir(mask_path);
ds = {'name', masks(3:13).name};
ds = table(ds);
for subj = 1 : length(subjs)
    niis = dir(fullfile(m_path, 'subjects', subjs{subj}));
    nii = niis(contains({niis.name}, strcat('sw', subjs{subj}, '_SUV.img'))).name;
    if ~isempty(nii)
        try
            subj_vol = spm_vol(fullfile(m_path, 'subjects', subjs{subj}, nii));
            vox_mat = spm_read_vols(subj_vol);
            for mask = 3 :length(mask)
                mask_vol = spm_vol(fullfile(mask_path, masks(mask).name));
                vox_mask = spm_read_vols(mask_vol);                
            end
        catch
            warning('subj %s does not have sw', subjs{subj})
        end
    end
end