%% OLD VERSION OF FILTER3.m !!
function [ mcar, nmcar, file , pvalues ] = filter3a(NonDropOut, DropOut, file)
% Statistical testing of variables for dropouts (DO) and non-dropouts(NDO). 
% The alternative hypothesis for each test means there is a significant 
% difference for DO and NDO for a certain variable. For different variables 
% different hypothesis testing are used. 
% Input: 
% - DropOut: table with measurements of the dropoput group. 
% - NonDropOut: table with measurements of the nondropout group.
% both tables are created in the main file. 
% - file: file with screening data which needs to be filtered for MCAR. 
% Output:
% - mcar: variables that have no significant difference for DO and NDO
% - nmcar: variables that have a significant difference for DO and NDO
% - file: file filtered for MCAR variables
% - p-values: resulting p-values of hypothesis testing for each variable. 

mcar = [];                                                                  % Reserve memory: Column numbers MCAR
nmcar = [];                                                                 % Reserve memory: Column numbers not MCAR
bincolumns = [2,4,5,10,11,13:16,25];                                           % Variables that take binary values 
ncolumns = [6,7,12,17,18,22:24,29,32,34,37,40:42,44,45,49,54];              % Continuous variables that do follow a normal distribution
nncolumns = [19:21,26:28,30,31,33,35,36,38,39,43,46:48,50:53,55:57];        % Continuous variables that do not follow a normal distribution
tricolumns = [3 9];
pvalues = [];

%% Perform 2-sided t-test for continuous variables that do follow a normal distribution. (ncolumns)
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
    pvalues(j) = p2;   
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
    pvalues(nn) = p3;   
    if h3 == 0               %Null hypothesis is accepted
        mcar = [mcar, nn];
    else
        nmcar = [nmcar, nn];  %Null hypothesis is rejected
    end  
end

%% Perform test for variables with 3 possible outcomes
% Perform chi-square test for discrete variables at 5% significance level.
% H0: data comes from common distribution
% H1: data does not come from common distribution
for tri = tricolumns 
    var_DO  = DropOut{:,tri}; 
    var_NDO = NonDropOut{:,tri};
    [h4,p4]   = chi2test2(var_DO,var_NDO,0.05); 
    pvalues(tri) = p4;
    if h4 == 0
        mcar = [mcar,tri];
    else 
        nmcar = [nmcar,tri];
    end
end
    
nmcar = sort(nmcar);         %Sort columns in ascending order
mcar  = sort(mcar);
%file = file(:,nmcar);        %Output file now only has the columns which are not MCAR
end

