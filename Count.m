function [count] = Count(file)
%counts amount of 1's in certain variables.
count=[];
variab = [1,4,7,9];
patients=height(file);
nr1=0;
for i = 1:length(variab)
    for j = 1:patients      
        if file{j,i}==1
            nr1=nr1+1;
        end
    end
    count = [count nr1];
    
    
end

