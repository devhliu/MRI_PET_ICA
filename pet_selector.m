% List of open inputs
% Named File Selector: File Set - cfg_files
nrun = X; % enter the number of runs here
jobfile = {'/home/coma_meth/Documents/antogeo/git_codes/MRI_PET_ICA2/pet_selector_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Named File Selector: File Set - cfg_files
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
