% List of open inputs
% Old Normalise: Estimate & Write: Source Image - cfg_files
% Old Normalise: Estimate & Write: Images to Write - cfg_files
nrun = X; % enter the number of runs here
jobfile = {'/home/coma_meth/Documents/antogeo/git_codes/MRI_PET_MNI+mask/Old_Norm_PET_8mm_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(2, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Old Normalise: Estimate & Write: Source Image - cfg_files
    inputs{2, crun} = MATLAB_CODE_TO_FILL_INPUT; % Old Normalise: Estimate & Write: Images to Write - cfg_files
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
