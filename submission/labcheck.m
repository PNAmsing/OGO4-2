function [ patnolab,patlab ] = labcheck( inputfile,missingness,low,high )
% This function will sort a file into patients who do and patients who do not
% miss the lab values. These variables all miss the same amount of data.
%   Input:      - A table with all patients and only "screening" appointments
%               - Array with missing values for screening appointment per variable in dataset
%               - Lowest and highest percentage of missing data, as a fraction (!) (e.g. 0.35
%               and 0.36)
%   Output:     2 tables with screening data for patients who respecticely 1) do not have lab
%   measurements and 2) have lab measurements

labcol=[];                              % Save memory for column numbers for lab values
low = low*height(inputfile);            % actual amount of missing values
high = high*height(inputfile);

for i = 1:length(missingness)
    value=missingness(i);
    if (value>low) && (value<high)      % If missingness is between the lower and upper threshold
        labcol = [labcol i];            % The variable is seen as a "lab column"
    end
end

patnolab = table;                       % Save memory for both patient types
patlab = table;

for j = 1:height(inputfile)             
    patsum=0;                           % The sum of missing values for one patient for the lab values starts at zero
    for k = labcol
        cell = inputfile{j,k};
        if isnan(cell)                  % All these columns only have floats, so it is empty when it is filled with NaN
            patsum = patsum + 1;        % If it is empty, the count is raised with 1
        end
    end
    
    if patsum >= length(labcol)-4       % If the count of empty cells is greater than or equal to the amount of lab values
                                           %The minus 4 is just a
                                           %correction for accuracy
        patnolab = [patnolab; inputfile(j,:)];      %Then the patient has no lab values
    else                                % Otherwise
        patlab = [patlab; inputfile(j,:)];  % Then the patient does have lab measurements
    end           
end
end

