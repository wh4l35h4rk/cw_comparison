function MakeHydrologyFolder(file_folder, hydro_file)

bath_file = "bath.txt";
dir = 'hydrology/';

if not(isfolder(dir))
    mkdir(dir)
end

hydro_M = readmatrix(fullfile(file_folder, hydro_file), FileType="text");
bath_M = readmatrix(bath_file);
r = bath_M(:, 1);

for i = 1:size(r)
    z = bath_M(i, 2);
    hydro_cut = hydro_M(1:round(z), :);

    new_name = [int2str(r(i)), '.hydr'];
    writematrix(hydro_cut, [dir, new_name], FileType="text", Delimiter='tab');
end

end