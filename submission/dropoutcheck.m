function [ dropout_type ] = dropoutcheck( patient_table )
%This function checks if patients finish treatment or not
%   input is a table of 6 rows with all patient data. The output is a true
%   or false value of dropout, which organizes the patients into four groups
%   in the main file. 
%   TYPES of dropout
%   1 = non-dropout
%   2 = potential dropout
%   3 = pure dropout
%   4 = immediate dropout
%   5 = remainder

emptylines=[];   
intcolumns=9:52;   %variables that are taken into account for measurements
lines = 1:6 ;        %all appointments of patient

for i = 1:length(lines)
    linenr=lines(i);    %line nr as input for absent function
    emptyline = absent(patient_table, intcolumns, linenr);  %checks if line i is an "empty" line, meaning that the patient didn't show up for the appointment
    emptylines = [emptylines, emptyline];    %total number of empty lines
end

%% Find types of dropout
% Emptylines contains a pattern of six 0's or 1's. The types of dropouts
% can be distinguished by different patterns. 
% 0 means complete, 1 means missing
% Definition immediate dropout 
% For immediate dropout only the data at moment of screening is known (=0)
% Data is missing at all following appointments (=1). Pattern: 011111
if emptylines(1) == 0 && mean(emptylines(2:6)) == 1
    dropout_type = 4;
% Definition potential dropout
% For potential dropout only the data at final appointment is missing (=1)
% Data is complete at all previous appointments (=0). Pattern: 000001
elseif sum(emptylines(1:5)) == 0 && emptylines(6) == 1
    dropout_type = 2; 
% Definition pure dropout 
% For potential dropout data is complete (=0) until one point. From that point
% on data start missing. (=1)
% Patterns: 001111 or 000111 or 000011
elseif sum(emptylines(1:2)) == 0 && mean(emptylines(3:6))== 1 || sum(emptylines(1:3)) == 0 && mean(emptylines(4:6))== 1 || sum(emptylines(1:4)) == 0 && mean(emptylines(5:6))== 1
    dropout_type = 3; 
% For some patients all data is missing. Pattern: 000000
elseif mean(emptylines(1:6)) == 1
    dropout_type = 5;
% All dropout types have been defined, so the remaining group consist of
% the non-dropouts. 
else
    dropout_type = 1;
end

end