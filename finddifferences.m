function [  ] = finddifferences( meansDrop,meansFin,headers )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%commen
datacombined=[meansDrop(:), meansFin(:)];
figure
hold on
x=length(meansDrop)
bar([1:x],datacombined,'grouped')
legend

end

