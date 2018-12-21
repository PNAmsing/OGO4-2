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
         figure(i); 
         var = Data{j}{:,con_var(i)};
         subplot(1,2,j); h = histogram(var,'normalization','probability');
         title(group{j}); 
         xlabel(var_names{con_var(i)}); ylabel('relative frequency'); 
         hold on
         mu = mean(var,'omitnan'); 
         sigma = std(var,'omitnan');
         normdata = h.BinWidth * 1/(sigma*sqrt(2*pi))*exp(-0.5*((var-mu)./sigma).^2);
         [var2,ix] = sort(var); normdata2 = normdata(ix);
         plot(var2,normdata2,'r-')
     end
 end
