# OGO Computational Biology group 4
Modelling drop-out in bariatric surgery follow-up
Made by: Rutger Van Doorslaer, Joris Vromans, Amy Vermeer en Naomie Amsing
Case coach: Ruben Deneer
Commissioning company: Catharina Hospital/ TU/e

Open main_file.m and run it. For this, you will need the file OGOCBIOBariatrieMissingness.csv. 
This file is provided by the Catharina Hospital and contains patient data.
1) reads in csv file as table
2) runs binarycolumns.m to change strings into binomial or trinomial values for certain columns
3) runs everysixth.m to take only the screening appointments in a new file scrfile.mat
4) it checks if missingness is already a file. If not, it makes missingness.m
	This file contains the number of missing values per variable at only the screening appointments
5) runs dropouttypes.m to add an extra column of dropouttype and organizes 
	the two different types into two different tables
	5.1) function absent.m checks whether a patient was present at a certain appointment
6) runs thresholding.m to filter out variables with too much missing data. Threshold is set at 20%
7) runs complete_cases.m to make new files which contain only the patients with complete data for the variables in step 6
8) runs statistics.m to find which variables differ significantly between drop outs and non drop outs
	8.1) check_normdistribution.m to plot distribution and find out distribution type
		8.1.1) Perform Chi^2 tests, two sided t tests and Wilcoxon rank sum tests for appropriate distributions

Steps 1-7 build the input table for the machine learning model
step 8 is a processing step.

Additional data processing steps are to analyse the different patient groups
1) Based on drop out type (tables from preprocessing)
2) Based on year of surgery (filterdatok.m)
3) Based on whether a patient has lab values or not (labcheck.m)

With countones.m, calculatemean.m and dropoutcheck.m, the patient demographics are mapped
