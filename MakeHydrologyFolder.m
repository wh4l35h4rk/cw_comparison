function MakeHydrologyFolder(file_folder, i)

file_list = dir(file_folder + "\*.hydr");
file_list = {file_list.name};
hydro_file = file_list{i}; 

bath_file = "bath.txt";
hydro_dir = 'hydrology/';

if not(isfolder(hydro_dir))
    mkdir(hydro_dir)
end

hydro_M = readmatrix(fullfile(file_folder, hydro_file), FileType="text");
bath_M = readmatrix(bath_file);
r = bath_M(:, 1);

for i = 1:size(r)
    z = bath_M(i, 2);
    hydro_cut = hydro_M(1:round(z), :);

    new_name = [int2str(r(i)), '.hydr'];
    writematrix(hydro_cut, [hydro_dir, new_name], FileType="text", Delimiter='tab');
end

end