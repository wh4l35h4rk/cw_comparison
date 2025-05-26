close all;
clear variables;
clc;

bath_sample_file = "profile.txt";

MakeBathFile(bath_sample_file);


dataset_folder = "!Hydrology-2015";
hydr_folder = 'hydrology_data';
samples_folder = "hydrology_samples";

GetHydrologyFromXLS(dataset_folder, hydr_folder);
FindSamples(hydr_folder, samples_folder);


i = 2;   % file index = 1..2

MakeHydrologyFolder(samples_folder, i);


