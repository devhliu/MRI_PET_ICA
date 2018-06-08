function [suv_list, mr_list] = select_mr_SUV(path)

%%% Creates a two lists with full path of T1 and SUV of Subjects. Subjects
% that miss one of the two modalities are shown in warning message
% Structure should be as follows: 
% subjects -> groups -> patients -> SUV & T1.

% path: string with the path of sbjects' folder
% return: two lists with the full paths


[~,pc_name]= system('hostname');
if regexp(string(pc_name), 'comameth')
    path = '/home/coma_meth/Documents/ICA_PET/dartel/Alice_Yorgos_Jitka/subjects/';
elseif regexp(pc_name, 'antogeo-XPS')
    path = '/home/antogeo/data/ICA_PET/dartel/Alice_Yorgos_Jitka/subjects/';
elseif regexp(pc_name, 'antogeo')
    path = 'home/antogeo/Documents/ICA_PET/dartel/Alice_Yorgos_Jitka/subjects/';
end
groups = dir(path);
groups = groups(3:size(groups)); 
suv_list = {};
mr_list = {};
for i = 1: size(groups, 1)
    if groups(i).isdir
       subj = dir(fullfile(path, groups(i).name));
        for k = 3: size(subj)
                contents = dir(fullfile(path, groups(i).name, subj(k).name));
            if strfind(contents(3).name, 'SUV')
                suv_list = [suv_list; contents(3).name];
                mr_list = [mr_list; contents(4).name];
            else
                suv_list = [suv_list; contents(4).name];
                mr_list = [mr_list; contents(3).name];
            end
        end
    end
end


for i = 1: size(suv_list, 1)
    [str_path, ~, ~] = fileparts(suv_list{i});
    [pet_path, ~, ~] = fileparts(mr_list{i});
    if ~strcmp(pet_path, str_path)
        fprintf('%s and %s in %d.\n', str_path, pet_path, i);
    end
end