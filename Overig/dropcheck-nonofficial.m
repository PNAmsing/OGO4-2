scrfiledot = everysixth(fullfile);
[ patnolab1,patlab1 ] = labrats( scrfiledot,missingness,0.35,0.36 );
var = 58;
drop = table;
nodrop = table;

for i = 1:height(patnolab1)
 type = patnolab1{i,var};
 if type == 1
     nodrop = [nodrop; patnolab1(i,:)];
 elseif type == 2
     drop = [drop; patnolab1(i,:)];
 elseif type == 3
     drop = [drop; patnolab1(i,:)];
 end
end