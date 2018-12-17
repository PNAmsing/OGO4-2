function [ emptyline ] = absent( patient_table,intcolumns,linenr )
% This function checks if the patient was present for appointment or not
%   Input: the data for the 6 appointments, the variables that are
%   considered "interesting" as defined in function dropoutcheck,
%   linenumber we are currently analysing (either 5 or 6)

%initialize variables
empty=[];   
emptyline=false;
j=linenr;

for k = intcolumns                  %for all columns as defined in input
    value=patient_table{j,k};       %the value of the cell from the patient_table
    emptycell=0;                    %initialize each cell as being 0
                                    %we have two different data types, so
                                    %we have two different options
    if isfloat(patient_table{1,k})     
        if isnan(value)             %we filled all empty cells with NaN
            emptycell = 1;          %then they are empty
        end

    elseif iscell(patient_table{1,k})
        if isempty(value{1})        %we filled all empty cells with empty strings
            emptycell = 1;          %then they are empty
        end
    end 

    empty = [empty; emptycell];     %array: dimension is the number of cells, where empty cells are 1 and non-empty cells are 0
end

if length(empty)==sum(empty)        %if all cells are empty, the length of the array has the same value as the sum of all values (then they are all equal to 1)
    emptyline = true;
end

end

