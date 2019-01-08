function [ filescr ] = everysixth( file )
%This function creates a new file which contains only the data for the
%screening appointments

filescr = table;
for x = 1:6:height(file)
    row = file(x,:);
    filescr=[filescr; row];
end

end

