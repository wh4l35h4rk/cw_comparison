function freqs = GetFrequencies(min_frequency, max_frequency)

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

end