function [ medianarray,stdarray ] = calculatemean( tablename)
%calculate the mean of each column and store this in a new array
%   Detailed explanation goes here

nrrows=height(tablename);
nrcolumns=width(tablename);
medianarray=[];
stdarray=[];

for z = 9: nrcolumns
    meancolumn=mean(tablename{:,z},'omitnan');
    stdcolumn = std(tablename{:,z}, 'omitnan');
    medianarray=[medianarray, meancolumn];
    stdarray=[stdarray, stdcolumn];
end

end

