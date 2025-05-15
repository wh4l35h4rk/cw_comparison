close all;
clear variables;
clc;

struct_list = dir(dataset_folder);
N = size(struct_list);

file_list = cell(N);
for i = 1:N
    file_list{i} = [struct_list(i).name];
end

file_list(1:2) = [];
N(1) = N(1) - 2;


hydr_folder = 'hydrology';
hydr_folder = 'hydrology_samples';
if not(isfolder(hydr_folder))
    mkdir(hydr_folder)
end

dz = 1;
for i = 1:N
    file = file_list{i};
    [~, basename, ~] = fileparts(file);

    table = readtable(fullfile(dataset_folder, file));
    cw = table.SOUNDVELOCITYM_SEC;

    M = length(cw);
    depth = (1:dz:M)';

    mat = [depth cw];
    writematrix(mat, [hydr_folder '\' basename '.hydr'], 'FileType', 'text', 'Delimiter', '\t')
end




