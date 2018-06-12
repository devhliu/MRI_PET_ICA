% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/home/coma_meth/Documents/antogeo/git_codes/MRI_PET_ICA2/selector_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'PET');
spm_jobman('run', jobs, inputs{:});
