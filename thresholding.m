function [ uitput,sigcol ] = thresholding( missingness,filename, uitput,threshold )
% This function filters out the variables with too much missingness
    % It takes into account how many empty cells there are because of
    % missed appointments (missingness) and then filters the variables with
    % significantly more missingness than that
    %ouput: new file without those variables (could be the same file as
    %"filename" but it doesn't have to be

threshold = threshold*height(filename);               %when 50% of the values for a variable is empty, it is too much

sigcol=[];
for l = 1:width(filename)-1
    if missingness(l) <= threshold
        sigcol = [sigcol l];                    %the columns that have enough values
    end
end

sigcol = sigcol([2:7 9:length(sigcol)]);

uitput=uitput(:, sigcol);                   %only the columns with more values than the threshold, are saved in the file

end

