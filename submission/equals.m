%%
%Script uitkomst:
%Table met een gelijk aantal dropouts als non-dropouts.
%%
%clear all
%complete_casesTOT = data; 
%%
for i = 1:height(complete_casesTOT)
    if complete_casesTOT{i,end} == 3
        complete_casesTOT{i,end} = 2;
    end
end
%% B  
just1=[];
just2=[];
equalLengthOf1=[];
randomRowNumbers=[];
%%
%Tables maken met enkel 1 en enkel 2
for i = 1:height(complete_casesTOT)
    if complete_casesTOT{i,end}==1
        just1=[just1; complete_casesTOT(i,1:width(complete_casesTOT))];
    else
        just2=[just2; complete_casesTOT(i,1:width(complete_casesTOT))];
    end
end
%%
%lijst maken waarin random gekozen rijnummers staan
for j = 1:height(just2)
    randomNumber=randi(height(just1));
    if ismember(randomRowNumbers,randomNumber)                  
        j=j-1;
    else
        randomRowNumbers=horzcat(randomRowNumbers,randomNumber); 
    end 
end
%%
%random gekozen rijen samenvoegen 
for k = randomRowNumbers
    equalLengthOf1=[equalLengthOf1;just1(k,1:width(just1))];
end

%%
%table maken waarin evenveel dropouts als niet dropouts zitten
equalMix=[equalLengthOf1;just2];
%%
mix41=[just1;just2;just2;just2;just2];