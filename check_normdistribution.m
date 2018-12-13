%% Script to check for normal distribution of variables
%  For a two-sample t-test the data in the variables need to be normally
%  distributed. This script checks the normal distrubution assumption for
%  the continuous variables in the dataset, which are age at surgery,
%  length, weight, lab measurements (except CRP), dist, PCSC and MCSC.

%% Dataset 
%  The two tables for dropout and non-dropout are stored in a cell so that 
%  each table can easily be recalled in a for-loop.
load('DropOut.mat'); load('NonDropOut.mat')
Data = {DropOut,NonDropOut};

%% Continuous variables
%  Con_var contains the column numbers of the continuous variables 
con_var = [6, 7, 12,17:24,26:57];
var_names = DropOut.Properties.VariableNames;
group = {'Dropout', 'Non-Dropout'};
%% Plot histogram of variables 
%  Histograms for each variable are plotted via histogram.m 

 for i = 1:length(con_var)
     for j = 1:size(Data,2)
         figure(i); title(var_names{i});
         var = Data{j}{:,con_var(i)};
         subplot(1,2,j); histogram(var,'normalization','probability');
         title({group{j} ; var_names{i}}); hold on;
         ylabel('relative frequency'); xlabel(var_names{con_var(i)}); 
         hold on
     end
 end
 
%% Plot normal probability plot
%  The normal probability plot is plotted for each variable via normplot.m.
%  The closer the data points are to the line, the more likely the 
%  assumption of a normal distribution is. 
 for i = 1:length(con_var)
     for j = 1:size(Data,2)
         figure(i); title(var_names{i});
         var = Data{j}{:,con_var(i)};
         subplot(1,2,j); normplot(var);
         hold on
     end
 end

%% Anderson-Darling test
% The Anderson-Darling test is a statistical test that checks whether a
% given sample of data is drawn from a certain probability distrubtion.
% adtest.m checks whether data is from a normal distribution. The null 
% hypothesis is that data is normally distributed. A value of 1 for h means
% the null hypothesis is being rejected. 
% Missing values, indicated by NaN, are ignored. 

h=[];
p=[];
 for i = 1:length(con_var)
     for j = 1:size(Data,2)
         var = Data{j}{:,con_var(i)};
         [hj,pj]=adtest(var);
         h(i,j) = hj; p(i,j)=pj;
     end
 end


