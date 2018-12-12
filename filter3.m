function [ mcar, nmcar, file , pvalues ] = filter3(NonDropOut, DropOut, file)
%2-sided t-test and chi squared test for the the Non-completing patients and for the
%completing patients per variable. Null hypothesis: equal medians
    %Input: tables with different patient groups. This file takes the
    %different kinds of drop outs together as general drop outs. File which
    %needs to be filtered for MCAR
    % Output: arrays with column numbers for MCAR and Not MCAR and the new
    % file which has been filtered. 

mcar = [];                          %Reserve memory: Column numbers MCAR
nmcar = [];                         %Reserve memory: Column numbers not MCAR
bcolumns = [2:5 9:11 13:16];        %Binary columns
dcolumns = [6 12 17:width(NonDropOut)]; %Double columns
pvalues = [];

for i = dcolumns                    %for columns with doubles, we use t-test
    x = table2array(NonDropOut(:,i));
    y = table2array(DropOut(:,i));
    
    [h1,p1] = ttest2(x,y, 'Vartype', 'unequal'); %Perform two sided t test
    pvalues(i) = p1;
    if h1 == 0                      %Null hypothesis is accepted
        mcar = [mcar, i];
    else
        nmcar = [nmcar, i];         %Null hypothesis is rejected
    end  
end


for j = bcolumns                    %For binary columns, we use a chi square test
%     nd = table2array(NonDropOut(:,j));
%     do = table2array(DropOut(:,j));
    succesnd = 0;                   %We set success cases per column to 0
    succesdo = 0;                   
    
    for k = 1:height(NonDropOut)    %Calculate success cases for non drop out group
        value = NonDropOut{k,j};
        if value == 1
            %'success rate'
            succesnd = succesnd + 1;
        end
    end
    
    for l = 1:height(DropOut)       %Calculate success cases for drop out group
        value = DropOut{l,j};
        if value == 1
            %'success rate'
            succesdo = succesdo + 1;
        end
    end
    
    w = [succesnd succesdo];        %Input for file: success cases for both groups
    z = [height(NonDropOut) height(DropOut)]; %Input for file: total cases for both groups
    
    [h2,p2] = prop_test(w,z,false);      %perform chi square test
    pvalues(length(dcolumns)+j) = p2;   
    if h2 == 0               %Null hypothesis is accepted
        mcar = [mcar, j];
    else
        nmcar = [nmcar, j];  %Null hypothesis is rejected
    end  
end

nmcar = sort(nmcar);         %Sort columns in ascending order
file = file(:,nmcar);        %Output file now only has the columns which are not MCAR
end

