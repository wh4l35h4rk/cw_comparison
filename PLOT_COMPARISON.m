close all;
clear variables;
clc;

% ИЩЕМ ТРЕТЬ-ОКТАВНЫЕ ЧАСТОТЫ

max_frequency = 10000;
min_frequency = 10;

N = 50;
freq_boundaries = zeros(N, 1);
freq_boundaries(1) = min_frequency;

i = 2;
while (freq_boundaries(i - 1) < max_frequency) 
    freq_boundaries(i) = freq_boundaries(i-1) * nthroot(2, 3);
    i = i + 1;
end
zero_index = find(freq_boundaries == 0, 1);

freq_boundaries = freq_boundaries(1:zero_index - 1, :);
M = length(freq_boundaries);


freqs = zeros(M - 1, 1);
for i = 1:M - 1 
    freqs(i) = sqrt(freq_boundaries(i) * freq_boundaries(i + 1));
end

% freqs = round(freqs);

clear zero_index N i 


% МЕНЯЕМ ЧАСТОТЫ В РАМСЕ

folder = 'npk_2025_05/';

lines = readlines([folder 'MainRAMS.txt']);
freq_line_index = 1;
while 1
    s = lines(freq_line_index);
    if (contains(s, 'freq'))
        break
    end
    freq_line_index = freq_line_index + 1;
end

TL = zeros(M - 1, 1);

for j = 1:M - 1
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





