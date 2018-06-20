clear; clc;
load('/home/coma_meth/Documents/antogeo/git_codes/dartel/mr_suv_lists.mat')
for i = 1: size(suv_list, 1)
    [pet_path, suv_name, ext_pet] = fileparts(suv_list{i});
    [mri_path, mri_name, ext_mri] = fileparts(mr_list{i});
    files = dir(pet_path);
    if ~exist(fullfile(pet_path, 'uni_seg'), 'dir')
         parts = split(pet_path, '/');
        fprintf('%s \n', parts{end})
        mkdir(fullfile(pet_path, 'uni_seg'))
        fprintf('Creating %s \n', (fullfile(pet_path, 'uni_seg')))
       
    end
    for j = 3: size(files, 1)
        if ~(strcmp(files(j).name, strcat(suv_name, ext_pet)) || ... 
                strcmp(files(j).name, strcat(mri_name, ext_mri)) || ...
                    strcmp(files(j).name, strcat(mri_name(4:end), ext_mri)))
            movefile(fullfile( ... 
                pet_path, files(j).name), fullfile(pet_path, 'uni_seg'))
        else
            fprintf('Not moving %s in %s.\n', ... 
                    files(j).name, fullfile(pet_path, 'uni_seg'));
        end
    end
end
