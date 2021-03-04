clear all
am = dir('*.dat');
for i =1:length(am)
    namereal = am(i).name(1:(length(am(i).name) - 4));
    runscript(namereal);
    cutscript;
    vityanut6(namereal);
end
