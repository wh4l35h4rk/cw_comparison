function MakeHydrologyFolderLauncher(samples_folder, i)

file_list = dir(samples_folder + "\*.hydr");
file_list = {file_list.name};
file = file_list{i}; 

MakeHydrologyFolder(samples_folder, file);
