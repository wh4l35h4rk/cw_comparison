close all;
clear variables;
clc;

foldername = "hydrology";
file_list = dir(foldername + "\*.hydr");
file_list = {file_list.name};

N = length(file_list);
thermocline_files = strings(N, 2);
same_soundspeed_files = strings(N, 2);

for i = 1:N
    file = load(fullfile(foldername, file_list{i}));
    c = file(:, 2);

    if (max(c) - min(c)) >= 10
        thermocline_files(i, 1) = file_list{i};
        thermocline_files(i, 2) = int2str(max(c) - min(c));
    elseif (max(c) - min(c)) <= 3
        same_soundspeed_files(i, 1) = file_list{i};
        same_soundspeed_files(i, 2) = max(c) - min(c);
    end

    thermocline_files = thermocline_files(~(thermocline_files(:, 1) == ""), :);
    same_soundspeed_files = same_soundspeed_files(~(same_soundspeed_files(:, 1) == ""), :);

    thermocline_files = rmmissing(thermocline_files);
    same_soundspeed_files = rmmissing(same_soundspeed_files);
end


deltas = str2double(thermocline_files(:, 2));
[~, row] = max(deltas);
tc_max = thermocline_files(row, :);

deltas = str2double(same_soundspeed_files(:, 2));
[~, row] = min(deltas);
ss_min = same_soundspeed_files(row, :);


tc_size = length(thermocline_files);
ss_size = length(same_soundspeed_files);

