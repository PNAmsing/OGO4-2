function [count] = count(file,variab)
%Counts amount of 1s in certain variables.
% Input: file which needs to be counted for column numbers in variab
% Output: count of 1s in an array. The index is the same index as the input array
% variab

count=[];
patients=height(file);

for i = variab
    nr1=0;
    
    for j = 1:patients  
        
        if file{j,i}==1
            nr1=nr1+1;
        end 
        
    end
    count = [count nr1];  
    
end