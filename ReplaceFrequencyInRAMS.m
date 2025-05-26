function ReplaceFrequencyInRAMS(project_folder, new_frequency)

lines = readlines([project_folder 'MainRAMS.txt']);
freq_line_index = 1;
while 1
    s = lines(freq_line_index);
    if (contains(s, 'freq'))
        break
    end
    freq_line_index = freq_line_index + 1;
end

words = split(s);
words{3} = [num2str(new_frequency) ';']; 
new_s = join(words);
new_s = new_s{1};

new_lines = [lines(1:freq_line_index - 1); new_s; lines(freq_line_index + 1:end)];
writelines(new_lines, [project_folder 'MainRAMS.txt'])

end