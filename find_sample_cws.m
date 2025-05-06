close all;
clear variables;
clc;

foldername = "hydrology";
file_list = dir(foldername + "\*.hydr");
file_list = {file_list.name};

N = size(file_list);
thermocline_files = cell(N);
same_soundspeed_files = cell(N);

for i = 1:N(2)
    file = load(fullfile(foldername, file_list{i}));

    c = file(:, 2);
    if (max(c) - min(c)) >= 10
        thermocline_files{i} = file_list{i};
    elseif (max(c) - min(c)) <= 3
        same_soundspeed_files{i} = file_list{i};
    end

    thermocline_files = thermocline_files(~cellfun(@isempty, thermocline_files));
    same_soundspeed_files = same_soundspeed_files(~cellfun(@isempty, same_soundspeed_files));
end
