function MakeBathFile(filename)

M = readmatrix(filename);

r = 1000 * M(:, 3);
z = -1 * M(:, 6);

writematrix([r z], "bath.txt", Delimiter="tab");

end
