function [ fullfilefilter,NonDropOut,DropOut, NonDrop, PotDrop,PureDrop,ImmDrop ] = dropouttypes( fullfilefilter )
%This function adds the drop out type to the file and makes new tables with
%the different types of drop outs (see function dropoutcheck)
%Input: file with patient data
%Output: file with extra columns in which drop out type is defined with a
%number and the 2 tables with patients divided in non drop out or drop out
%The files NonDropOut en DropOut contain only the screening appointments

                                                
% Create empty tables to store values for the five types of patients 
NonDrop = table;                                                             
PotDrop = table;                                                                 
PureDrop = table; 
ImmDrop = table; 
Rest = table;

patnrs = 1:6:height(fullfilefilter);                                        %Row numbers of first instances of each patient

fullfilefilter.dropouttype = zeros(height(fullfilefilter),1);

for i = patnrs
    patient_table = fullfilefilter(i:i+5,:);                                %A subtable is made for all patients
    dropout_type = dropoutcheck(patient_table);                             %this subtable is called in the function Dropout check to check if they are drop-outs
    patient_table = patient_table(1,:);
    fullfilefilter.dropouttype(i) = dropout_type;
    patient_table = fullfilefilter(i:i+5,:);
    patient_table = patient_table(1,:);
    
    if dropout_type == 1
        NonDrop = [NonDrop; patient_table];                                
    elseif dropout_type == 2
        PotDrop = [PotDrop; patient_table];                              
    elseif dropout_type == 3 
        PureDrop = [PureDrop; patient_table];
    elseif dropout_type == 4 
        ImmDrop = [ImmDrop; patient_table];
    elseif dropout_type == 5
        Rest = [Rest; patient_table]; 
    end
    
end

DropOut=table;
NonDropOut=table;
DropOut=[PotDrop; PureDrop];
NonDropOut=[NonDrop];

end

