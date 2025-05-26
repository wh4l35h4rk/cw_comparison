close all;
clear variables;
clc;

nmod = 10;
dz = [1, 1];
f = [20, 500];
folder = 'npk_2025_05/';

addpath(folder);

indices = [1, 2];
names = ["Homogenous cold water", "Thermocline"];
samples_folder = 'hydrology_samples/';

figure;
for k = indices
    MakeHydrologyFolder(folder, samples_folder, k)

    subplot(1, 2, k)
    N = 3;
    for i = 1:length(f)
        ReplaceFrequencyInRAMS(folder, f(i));
        [wNum, ~, wmode] = ModeDecomposition(folder, nmod, dz(i));

        z = 1:length(wmode);
        if mod(i, 2) == 1
            style = ':';
        else
            style = '-';
        end

        for j = 1:N

            semilogy(wmode(:, j), z', 'LineStyle', style, ...
                    'DisplayName', ['Mode #', int2str(j), ', ' int2str(f(i)), ' Hz']);
            hold on
        end
    end
    title(names(k))
    xlabel('Modal function');
    ylabel('Depth, m');
    set(gca, 'YDir', 'reverse')
    legend(Location="southeast")
    grid on
    hold off
end