function PlotResults(foldername, thermocline_files, same_soundspeed_files, ...
                     tc_max, ss_min)

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
