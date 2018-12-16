function [ mcar, nmcar, file , pvalues ] = filter3(NonDropOut, DropOut, file)
%2-sided t-test and chi squared test for the the Non-completing patients and for the
%completing patients per variable. Null hypothesis: equal means
    %Input: tables with different patient groups. This file takes the
    %different kinds of drop outs together as general drop outs. File which
    %needs to be filtered for MCAR
    % Output: arrays with column numbers for MCAR and Not MCAR and the new
    % file which has been filtered. 

mcar = [];                          %Reserve memory: Column numbers MCAR
nmcar = [];                         %Reserve memory: Column numbers not MCAR
bincolumns = [2,4,5,10,11,13:16];        % Variables that take binary values 
ncolumns = [6,7,12,17,18,22:24,29,32,34,37,40:42,44,45,49,54];          % Continuous variables that do follow a normal distribution
nncolumns = [19:21,26:28,30,31,33,35,36,38,39,43,46:48,50:53,55:57];                     % Continuous variables that do not follow a normal distribution
tricolumns = [3 9];
pvalues = [];

%% Perform 2-sides t-test for continuous variables that do follow a normal distribution. (ncolumns)
for i = ncolumns                    
    x = table2array(NonDropOut(:,i));
    y = table2array(DropOut(:,i));
    
    [h1,p1] = ttest2(x,y, 'Vartype', 'unequal'); %Perform two sided t test
    pvalues(i) = p1;
    if h1 == 0                      % Null hypothesis is accepted
        mcar = [mcar, i];
    else
        nmcar = [nmcar, i];         %Null hypothesis is rejected
    end  
end

%% Perform chi-squared test for variables that take binary values. (bincolumns)
for j = bincolumns                    
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
    pvalues(bincolumns) = p2;   
    if h2 == 0               %Null hypothesis is accepted
        mcar = [mcar, j];
    else
        nmcar = [nmcar, j];  %Null hypothesis is rejected
    end  
end

%% Perform Wilcoxon rank sum test for variables that do no follow a normal distribution. (nncolumns)
for nn = nncolumns   
    nnvar_do = DropOut{:,nn};
    nnvar_ndo = NonDropOut{:,nn}; 
    [p3,h3] = ranksum(nnvar_do,nnvar_ndo);
    pvalues(nncolumns) = p3;   
    if h3 == 0               %Null hypothesis is accepted
        mcar = [mcar, nn];
    else
        nmcar = [nmcar, nn];  %Null hypothesis is rejected
    end  
end

%% Perform test for variables with 3 possible outcomes
    outcomes_DO  = unique(DropOut{:,tt}); 
    outcomes_DO  = outcomes_DO(~isnan(outcomes_DO));        
    if length(outcomes_NDO) ~= length(outcomes_DO)          % Check if possible outcomes are the same for both groups
        disp('Different possible outcomes for Dropout and Non-dropout')
    end
    prop_NDO = []; prop_DO = [];                            % Save memory to store the counts of each possible outcome
    for outcome = 1:length(outcomes_DO)
        count_DO = length(find(DropOut{:,tt}==outcomes_DO(outcome)));       % Count how many times a certain value occurs in dropout group
        count_NDO= length(find(NonDropOut{:,tt}==outcomes_NDO(outcome)));   % Count how many times a certain value occurs in nondropout group
        prop_NDO = [prop_NDO,count_NDO];                                    % Store the counts in arrays.  
        prop_DO  = [prop_DO,count_DO];                                      % These 'proportions' are needed for hypothesis testing.
    end
    % implement Statistical test 
    
    
end
nmcar = sort(nmcar);         %Sort columns in ascending order
file = file(:,nmcar);        %Output file now only has the columns which are not MCAR
end

