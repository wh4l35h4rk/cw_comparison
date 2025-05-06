close all;
clear variables;
clc;

foldername = "hydrology";
file_list = dir(foldername + "\*.hydr");
file_list = {file_list.name};


N = length(file_list);
thermocline_files = strings(N, 2);
same_soundspeed_files = strings(N, 2);
long_ss_files = strings(N, 2);

for i = 1:N
    file = load(fullfile(foldername, file_list{i}));
    filesize = size(file);
    c = file(:, 2);

    if (max(c) - min(c)) >= 10
        thermocline_files(i, 1) = file_list{i};
        thermocline_files(i, 2) = int2str(max(c) - min(c));
    elseif (max(c) - min(c)) <= 3
        same_soundspeed_files(i, 1) = file_list{i};
        same_soundspeed_files(i, 2) = max(c) - min(c);
        if filesize(1) >= 120
            long_ss_files(i) = same_soundspeed_files(i);
        end
    end

    thermocline_files = thermocline_files(~(thermocline_files(:, 1) == ""), :);
    same_soundspeed_files = same_soundspeed_files(~(same_soundspeed_files(:, 1) == ""), :);
    long_ss_files = long_ss_files(~(long_ss_files(:, 1) == ""), :);

    thermocline_files = rmmissing(thermocline_files);
    same_soundspeed_files = rmmissing(same_soundspeed_files);
    long_ss_files = rmmissing(long_ss_files);
end


deltas = str2double(thermocline_files(:, 2));
[~, row] = max(deltas);
tc_max = thermocline_files(row, :);

deltas = str2double(long_ss_files(:, 2));
[~, row] = min(deltas);
ss_min = long_ss_files(row, :);



tc_size = length(thermocline_files);
ss_size = length(same_soundspeed_files);

figure;

for i = 1:tc_size
    file = load(fullfile(foldername, thermocline_files(i, 1)));
    z = file(:, 1);
    c = file(:, 2);
    
    if thermocline_files{i, 1} ~= tc_max(1)
        plot(c, z, 'Color', [0.8 0.8 0.8], 'LineWidth', 0.3)
        set(gca, 'YDir', 'reverse')
        hold on
    end
end

file = load(fullfile(foldername, tc_max(1)));
filesize = size(file);
plot(file(:, 2), file(:, 1), 'Color', 'red', 'LineWidth', 1)

ylim([0, filesize(1)])
% title("Профили скорости звука: термоклин")
xlabel("c, м/с")
ylabel("z, м")
hold off


figure;

for i = 1:ss_size
    file = load(fullfile(foldername, same_soundspeed_files(i, 1)));
    z = file(:, 1);
    c = file(:, 2);
    
    if same_soundspeed_files{i, 1} ~= ss_min(1)
        plot(c, z, 'Color', [0.8 0.8 0.8], 'LineWidth', 0.3)
        set(gca, 'YDir', 'reverse')
        hold on
    end
end

file = load(fullfile(foldername, ss_min(1)));
plot(file(:, 2), file(:, 1), 'Color', 'red', 'LineWidth', 1)

% title("Профили скорости звука: циклон")
xlabel("c, м/с")
ylabel("z, м")
hold off



% ТЕРМОКЛИН И ЦИКЛОН НА ОДНОМ ГРАФИКЕ

figure;

for i = 1:tc_size
    file = load(fullfile(foldername, thermocline_files(i, 1)));
    z = file(:, 1);
    c = file(:, 2);
    
    if thermocline_files{i, 1} ~= tc_max(1)
        plot(c, z, 'Color', [0.8 0.8 0.8], 'LineWidth', 0.3)
        set(gca, 'YDir', 'reverse')
        hold on
    end
end

for i = 1:ss_size
    file = load(fullfile(foldername, same_soundspeed_files(i, 1)));
    z = file(:, 1);
    c = file(:, 2);
    
    if same_soundspeed_files{i, 1} ~= ss_min(1)
        plot(c, z, 'Color', [0.8 0.8 0.8], 'LineWidth', 0.3)
        set(gca, 'YDir', 'reverse')
        hold on
    end
end

file = load(fullfile(foldername, ss_min(1)));
plot(file(:, 2), file(:, 1), 'Color', 'red', 'LineWidth', 1)

file = load(fullfile(foldername, tc_max(1)));
filesize = size(file);
plot(file(:, 2), file(:, 1), 'Color', 'red', 'LineWidth', 1)

ylim([0, filesize(1)])
title("Профили скорости звука")
xlabel("c, м/с")
ylabel("z, м")

hold off
