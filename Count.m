function [count] = Count(file,variab)
%counts amount of 1's in certain variables.
count=[];
% variab = [10,5,9];
patients=height(file);

for i = variab
    nr1=0;
    for j = 1:patients      
        %if isempty(file{j,i})==0
        if file{j,i}==1
            nr1=nr1+1;
        end 
    end
    count = [count nr1];
        
end

