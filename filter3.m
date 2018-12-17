function [ mcar, nmcar, file , pvalues ] = filter3(NonDropOut, DropOut, file)
% Statistical testing of variables for dropouts (DO) and non-dropouts(NDO). 
% The alternative hypothesis for each test means there is a significant 
% difference for DO and NDO for a certain variable. For different variables 
% different hypothesis testing are used. 
% Input: 
% - DropOut: table with measurements of the dropoput group. 
% - NonDropOut: table with measurements of the nondropout group.
% - file: file with screening data which needs to be filtered for MCAR. 
% Output:
% - mcar: variables that have no significant difference for DO and NDO
% - nmcar: variables that have a significant difference for DO and NDO
% - file: file filtered for MCAR variables
% - p-values: resulting p-values of hypothesis testing for each variable. 
mcar = {}; nmcar = {}; pvalues=[];  % Reserve memory
% Variables that take binary values 
bincolumns = {'geslacht','procok','compl','alcohol','depri','hypert','diabet','dyslip','osas','CRP'}; 
% Continuous variables that do follow a normal distribution
ncolumns = {'age_at_surgery', 'lengte','gewicht','albumin','ALP','calcium', 'cholesterol','cholHDLratio','phosphate',...
            'HDL','hemoglobin','potassium','LDL','LD','leukocytes','MCV','sodium','thrombocytes','vitB1'};
% Continuous variables that do not follow a normal distribution
nncolumns = {'ALAT','ASAT','bilirubin','erythrocytes','ferritin','folate','glucose','GGT','hematocrit','HbA1c', 'iron',...
            'creatinine','MDRD','MCH','PTH','PT','triglycerides','urea','vitB6','vitB12','vitD25OH','PCSC','MCSC','dist'};        
tricolumns = {'datok','roken'};
it = 1;
for col = DropOut.Properties.VariableNames 
%% Perform 2-sided t-test for continuous variables that do follow a normal distribution. (ncolumns)
    if ismember(col,ncolumns) == 1
        x = table2array(NonDropOut(:,col));
        y = table2array(DropOut(:,col));
        [h1,p1] = ttest2(x,y, 'Vartype', 'unequal'); %Perform two sided t test
        pvalues(it) = p1;
        if h1 == 0                      % Null hypothesis is accepted
            mcar{end+1} = col;
        else
            nmcar{end+1} = col;         %Null hypothesis is rejected
        end  
%% Perform chi-squared test for variables that take binary values. (bincolumns)
    elseif ismember(col,bincolumns) == 1
        succesnd = 0;                   %We set success cases per column to 0
        succesdo = 0;                   

        for k = 1:height(NonDropOut)    %Calculate success cases for non drop out group
            value = NonDropOut{k,col};
            if value == 1
            %'success rate'
                succesnd = succesnd + 1;
            end
        end
    
        for l = 1:height(DropOut)       %Calculate success cases for drop out group
            value = DropOut{l,col};
            if value == 1
            %'success rate'
                succesdo = succesdo + 1;
            end
        end
        w = [succesnd succesdo];        %Input for file: success cases for both groups
        z = [height(NonDropOut) height(DropOut)]; %Input for file: total cases for both groups
    
        [h2,p2] = prop_test(w,z,false);      %perform chi square test
        pvalues(it) = p2;   
        if h2 == 0               %Null hypothesis is accepted
            mcar{end+1} = col;
        else
            nmcar{end+1} = col;  %Null hypothesis is rejected
        end  
%% Perform Wilcoxon rank sum test for variables that do no follow a normal distribution. (nncolumns)
    elseif ismember(col,nncolumns) == 1 
        nnvar_do = DropOut{:,col};
        nnvar_ndo = NonDropOut{:,col}; 
        [p3,h3] = ranksum(nnvar_do,nnvar_ndo);
        pvalues(it) = p3;   
        if h3 == 0               %Null hypothesis is accepted
            mcar{end+1} = col;
        else
            nmcar{end+1} = col;  %Null hypothesis is rejected
        end  
%% Perform test for variables with 3 possible outcomes
% Perform chi-square test for discrete variables at 5% significance level.
% H0: data comes from common distribution H1: data does not come from common distribution
    elseif ismember(col,tricolumns) == 1
        var_DO  = DropOut{:,col}; 
        var_NDO = NonDropOut{:,col};
        [h4,p4]   = chi2test2(var_DO,var_NDO,0.05); 
        pvalues(it) = p4;
        if h4 == 0
            mcar{end+1} = col;
        else 
            nmcar{end+1} = col;
        end
    end
    
    it = it + 1;
end

%file = file(:,nmcar);        %Output file now only has the columns which are not MCAR
end

