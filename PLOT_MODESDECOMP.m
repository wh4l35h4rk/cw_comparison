close all;
clear variables;
clc;

nmod = 10;
dz = 1;
f = [20, 500];
folder = 'npk_2025_05/';

addpath(folder);

indices = [1, 2];
names = ["Homogenous cold water", "Thermocline"];
samples_folder = 'hydrology_samples/';

for k = indices
    MakeHydrologyFolderLauncher([folder samples_folder], k)

    figure;
    N = 3;
    for i = 1:length(f)
        [wNum, ~, wmode] = ModeDecomposition(folder, nmod, dz, f(i));
        z = 1:length(wmode);

        for j = 1:N
            semilogy(wmode(:, j), z', ...
                    'DisplayName', ['Mode #', int2str(j), ', ' int2str(f(i)), ' Hz']);
            hold on
        end
        title(names(k))
        xlabel('Modal function');
        ylabel('Depth, m');
        set(gca, 'YDir', 'reverse')
        legend()
        grid on
    end
end