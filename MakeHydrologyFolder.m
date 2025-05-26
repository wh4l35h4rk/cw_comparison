function MakeHydrologyFolder(project_folder, samples_folder, i)

samples_path = fullfile(project_folder, samples_folder);
hydro_path = [project_folder 'hydrology/'];

if not(isfolder(hydro_path))
    mkdir(hydro_path)
end

bath_file = "bath.txt";


file_list = dir(samples_path + "\*.hydr");
file_list = {file_list.name};
hydro_file = file_list{i};

hydro_M = readmatrix(fullfile(samples_path, hydro_file), FileType="text");
bath_M = readmatrix(bath_file);
r = bath_M(:, 1);

for i = 1:size(r)
    z = bath_M(i, 2);
    hydro_cut = hydro_M(1:round(z), :);

    new_name = [int2str(r(i)), '.hydr'];
    writematrix(hydro_cut, [hydro_path, new_name], FileType="text", Delimiter='tab');
end

end