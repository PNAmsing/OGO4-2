function [ pat2012,pat2013,pat2014 ] = filterdatok( scrfile )
%Make different patient tables, selected on the year the patients received
%surgery.
% input: patient file with only screening appointments
% output: patient files for groups based on the surgery year

var = {'datok'};
pat2012 = table;
pat2013 = table;
pat2014 = table;

for i = 1:height(scrfile)
    year = scrfile{i,var};
    if year == 2012
        pat2012 = [pat2012; scrfile(i,:)];
    elseif year == 2013
        pat2013 = [pat2013; scrfile(i,:)];
    elseif year == 2014
        pat2014 = [pat2014; scrfile(i,:)];
    end
end

end

