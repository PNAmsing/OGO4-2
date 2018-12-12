%% Main file to organize the patients into either drop outs or patients who
%finish the treatment and to preprocess the file
%% Read in file and convert to proper data type
clear all -except missingness, close all;

fullfile = readtable('OGOCBIOBariatriemissingness.csv');                   %Read in the data as a table

fullfile = binarycolumns(fullfile);
scrfile = everysixth(fullfile);

%% Calculate missingness
% Function for filtering out missingness type 2. Missingness contains the 
%number of missing values per variable
if exist('missingness','var')==0
    [missingness]=missingness(scrfile);
end

%% Organize for type of missingness
[fullfile,NonDropOut,DropOut] = dropouttypes( fullfile );

%% Filter for too much missing data
%This function will filter out the variables with too much missing
%measurements even though the patients were present at the appointment
[~,sigcol]=filter2(missingness,scrfile,scrfile,0.2);

%% Make new file with only complete cases
% Patients who have measurements for all significant values
[complete_casesDO]=complete_cases(sigcol,DropOut);
[complete_casesNDO]=complete_cases(sigcol,NonDropOut);
complete_casesTOT=[complete_casesDO; complete_casesNDO];

%% Statistical testing
%This function will filter out the variables which predict complete
%randomness for the different groups
scrfile1=table;
scrfile1=[NonDropOut;DropOut];
[mcar,nmcar,scrfilefilter2,pvalues] = filter3(NonDropOut, DropOut,scrfile1);

%[num,txt,raw]=xlsread('OGOCBIOBariatriemissingness.csv','A1:BE1');             %find headers for all variables
%headers=txt;

