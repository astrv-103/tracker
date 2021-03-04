function cutscript
delete outcut*
am = dir('commet*');
global num prop
num =1;
prop = [];
for i = 1:length(am)
    am(i).name
    cuttnode (am(i).name);
    
end
%save( [name 'props.mat'], 'prop');
end