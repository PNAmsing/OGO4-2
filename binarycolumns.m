function [ file ] = binarycolumns( file )
%This function converts strings to doubles. It is specific for the file
%"OGOCBIOBariatriemissingness"
% Input: table with different data types
% Output: table with converted columns

%% Convert categorical values into 0 and 1 
%These strings should be converted to binary numbers
convertto1={'yes','>6','bypass','F'};
convertto0={'no', 'never','<=6','sleeve','M'};
convertto2={'quit'}; 

% These variables have data type cell but should have data type float
variables = {'geslacht','procok','compl','roken','alcohol','hypert','diabet','dyslip','osas','CRP'};

for i = 1 : height(file)
    for k = 1 : length(variables)
        j = variables(k);
        cellvalue=file{i,j}{1};
        if ismember(cellvalue, convertto1) == 1
            file{i,j}{1}='1';
        elseif ismember(cellvalue, convertto0) == 1
            file{i,j}{1}='0';
        elseif ismember(cellvalue, convertto2) == 1
            file{i,j}{1}='2';
        end
    end   
end
%% Convert strings to doubles
columnstrings=[2 4 5 7 9:57];                                              %The strings in the table are made into doubles so
for i = columnstrings                                                      %calculations can be done with the numbers (e.g. average)
    file.(i)=str2double(file.(i));
end 
 
% fullfile=standardizeMissing(fullfile,{'NA',''});                         %With this function, all missing values are set to NaN to both the full file and the file with only screenings                                   

end

