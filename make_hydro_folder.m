close all;
clear variables;
clc;

hydro_file = "HYDROLOGY FILE";
bath_file = "bath.txt";
dir = 'hydrology/';

hydro_M = readmatrix(hydro_file, FileType="text");
bath_M = readmatrix(bath_file);
r = bath_M(:, 1);

for i = 1:size(r)
    z = bath_M(i, 2);
    hydro_cut = hydro_M(1:round(z), :);

    new_name = [int2str(r(i)), '.hydr'];
    writematrix(hydro_cut, [dir, new_name], FileType="text", Delimiter='tab');
end
