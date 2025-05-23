close all;
clear variables;
clc;

folder = 'npk_2025_05/';
addpath(folder);


min_frequency = 10;
max_frequency = 1000;

freqs = GetFrequencies(min_frequency, max_frequency);
M = length(freqs);


lines = readlines([folder 'MainRAMS.txt']);
freq_line_index = 1;
while 1
    s = lines(freq_line_index);
    if (contains(s, 'freq'))
        break
    end
    freq_line_index = freq_line_index + 1;
end

TL = zeros(M, 1);

for j = 1:M
    new_freq = freqs(j);
   
    words = split(s);
    words{3} = [num2str(new_freq) ';']; 
    new_s = join(words);
    new_s = new_s{1};

    new_lines = [lines(1:freq_line_index - 1); new_s; lines(freq_line_index + 1:end)];
    writelines(new_lines, [folder 'MainRAMS.txt'])


    RunModel(folder)
    
    results_folder = 'results/';
    tl_file = readmatrix([folder results_folder 'tl.nLine.Txt']);
    TL(j) = tl_file(end, 4);
end

TL_matrix = [freqs TL];

postfix = 'thermocline';    % change for different samples
writematrix(TL_matrix, [folder 'tl_' postfix],  Delimiter='tab')

x = TL_matrix(:, 1); 
y = TL_matrix(:, 2); 

figure

plot(x, y, 'LineWidth', 2); 
set(gca, 'XScale', 'log');
xlabel('frequency, Hz');
ylabel('TL, dB');
title('TL(f)');
grid on;
