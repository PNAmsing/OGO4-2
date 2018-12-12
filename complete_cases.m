function [file] = complete_cases (variables,file )
%% This function finds the complete cases on the selected variables in the given dataset. 
% Variables are selected based on their missing value rates. In this array
% are distance (var. 57) and roken (var. 9) not included (yet). 

%variables = [2,4,6,7,10,12,13,14,15,16,30];

variables = [variables 9 57 58];

% Total number of patients
patients = height(file);

% Create array to store the numbers of patients that are considered to be a
% complete case based on this variables.

complete_cases2 = [];
for pat = 1 : patients
    % Sum is set to zero, to count the number of present values for each
    % patient. 
    sum = 0;
    for var = 1 : length(variables)

    % Check if variable is measured. If so, one is added to sum. 
        if ~isnan(file{pat,variables(var)})

            sum = sum + 1;
        else 
            sum = sum;
        end
    end
    % If all variables were measured, sum should be equal to the total
    % number of variables. Complete_cases2 returns the row numbers in which
    % a complete case was found. 
    if sum == length(variables)

        complete_cases2 = [complete_cases2; pat];         
    end
end

%%  Make new files
file = file(complete_cases2,variables);