%% standardize data

mean_var = []; std_var = [];
for i = 1:width(complete_casesTOT)-1
    mean_var(i) = mean(complete_casesTOT{:,i});
    std_var(i)  = std(complete_casesTOT{:,i});
end
mean_var = [mean_var,0]; std_var = [std_var,1];
complete_casesTOT_stand = array2table(((table2array(complete_casesTOT)) - mean_var)./std_var);  



