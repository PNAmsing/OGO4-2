function [ fullfile ] = binarycolumns( fullfile )
%This function converts strings to doubles
%% Convert categorical values into 0 and 1 
%These strings should be converted to binary numbers
convertto1={'yes','>6','bypass','F'};
convertto0={'no', 'never','<=6','sleeve','M'};
convertto2={'quit'}; 
variables = [2,4,5,9,10,11,13,14,15,16,25];
for i = 1 : height(fullfile)
    for k = 1 : length(variables)
        j = variables(k);
        cellvalue=fullfile{i,j}{1};
        if ismember(cellvalue, convertto1) == 1
            fullfile{i,j}{1}='1';
        elseif ismember(cellvalue, convertto0) == 1
            fullfile{i,j}{1}='0';
        elseif ismember(cellvalue, convertto2) == 1
            fullfile{i,j}{1}='2';
        end
    end   
end
%% Convert strings to doubles
columnstrings=[2 4 5 7 9:57];                                              %The strings in the table are made into doubles so
for i = columnstrings                                                      %calculations can be done with the numbers (e.g. average)
    fullfile.(i)=str2double(fullfile.(i));
end 
 
% fullfile=standardizeMissing(fullfile,{'NA',''});                            %With this function, all missing values are set to NaN to both the full file and the file with only screenings                                   

end

