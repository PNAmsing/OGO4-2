function [ missingness ] = missingness( filename )
%This function checks the number of empty lines in the file
%   Input: file with data
%    Output: number of empty lines in the file per variable

missingness=[];                         %Array with number of empty cells per variable

for i = 1:width(filename)                 %Check for all variabels
    nrempty = 0;                        %Number of empty cells for column i
        
    for j = 1:height(filename)
        
        if isfloat(filename{j,i})     
            if isnan(filename{j,i})             %we filled all empty cells with NaN
                nrempty = nrempty+ 1;          %then they are empty
            end

        elseif iscell(filename{j,i})
            if isempty(filename{j,i}{1})        %we filled all empty cells with empty strings
                nrempty = nrempty+ 1;          %then they are empty
            end
            
        end
        nrempty;
    end
    missingness = [missingness nrempty];    %this array contains the number of missing values per variable 
                                            %(column number in this array is the same as the column number in the original file)
    
end

end

