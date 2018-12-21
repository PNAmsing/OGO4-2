%% Add extra columns so dropout names can be added. 
data = complete_casesTOT;
newString = "Dropout type";
data.newVar(:) = {newString}; 
for pat = 1 : height(data)
    if data{pat,end-1} == 1
       data{pat,end} = {'Non dropout'};
    elseif data{pat,end-1} == 2 || 3
        data{pat,end} = {'Dropout'};
    end
end

%% After running classification leaner, figures can be saved this way. 
% De tweede invoeroptie bij print geeft naam aan figuur, dus die moet
% iedere keer aangepast worden. 
% https://nl.mathworks.com/matlabcentral/answers/231614-how-can-i-copy-and-paste-figures-from-classification-learner
hFigs = findall(groot,'type','figure');
print(hFigs(1),'Confusion matrix','-dpng');
print(hFigs(2),'ROC','-dpng');