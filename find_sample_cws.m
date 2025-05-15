close all;
clear variables;
clc;

foldername = "hydrology";
file_list = dir(foldername + "\*.hydr");
file_list = {file_list.name};

N = length(file_list);
thermocline_files = strings(N, 2);
same_soundspeed_files = strings(N, 2);
shelf_tc_files = strings(N, 2);

for i = 1:N
    file = load(fullfile(foldername, file_list{i}));
    filesize = size(file);
    c = file(:, 2);

    if (max(c) - min(c)) >= 5
        thermocline_files(i, 1) = file_list{i};
        thermocline_files(i, 2) = int2str(max(c) - min(c));

        [~, row_end] = FindThermocline(file);
        if row_end <= 20
            shelf_tc_files(i) = thermocline_files(i);
        end

    elseif (max(c) - min(c)) <= 3
        same_soundspeed_files(i, 1) = file_list{i};
        same_soundspeed_files(i, 2) = mean(c);
    end

    thermocline_files = thermocline_files(~(thermocline_files(:, 1) == ""), :);
    same_soundspeed_files = same_soundspeed_files(~(same_soundspeed_files(:, 1) == ""), :);
    shelf_tc_files = shelf_tc_files(~(shelf_tc_files(:, 1) == ""), :);

    thermocline_files = rmmissing(thermocline_files);
    same_soundspeed_files = rmmissing(same_soundspeed_files);
    shelf_tc_files = rmmissing(shelf_tc_files);
end


deltas = str2double(shelf_tc_files(:, 2));
[~, row] = max(deltas);
tc_max = shelf_tc_files(row, :);

means = str2double(same_soundspeed_files(:, 2));
[~, row] = min(means);
ss_min = same_soundspeed_files(row, :);

copyfile(fullfile(foldername, tc_max(1)), '.');
copyfile(fullfile(foldername, ss_min(1)), '.');


PlotResults(foldername, thermocline_files, same_soundspeed_files, tc_max, ss_min)


