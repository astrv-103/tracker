
clear var
%{
Code is devoted to accurate tracking biological objects comets. These objects are part of cell skeleton. This program takes as input sequence of microscope images. It allows finding dependence of comet tail length of comet on it velocity. Code consists of matlab scripts and using standard matlab functions, but main function related to topology was developed by c++ code and mex matlab functional. Workability was tested only for windows and matlab version higher than 2017a, but we did running this code on matlab in ubuntu ver 20.04.
So far this code works correctly only with our microscopic images. If you want to use your own images, there is possible the adjustment of parameters will be required. Without this correct work of this code is not guaranteed.   
To install just copy files to your directory. The mainscript.m is file that contain all function and routing for compilation. This code is work with sequences of microscopic images with .GIF file extension. The dirf variable is related to file path to you data directory. Should note that program deals with sequences of directoties. Each directory must contain sequence of GIF images. If you have only one sequence, make separate directory and put your sequence in this directory. So all paths to you gif images must be like:
…./data/fistatemp/1file.gif
Program allows to work with several data directories:
…/data/secondatemp
…/data/thirdatemp
In this case program will process all data and file of result will have prefix “firstatemp”, “secondatemp” and so on related to directory name.  
dirf variable is a string contains related to data path. Change this variable to you file path:
dirf = 'd:/work/youdatapath';

In this case path to any of gif image must be like d:/work/youdatapath/fristatemp/1.gif
As we said <fristatemp> will be prefix. And all output files will be fristatemp<…>.mat
Mainscript consist of several function – routing. After every routing result will be saved in file with special postfix. It allows to not lost all process data if calculation will be stop. Almost every function – routing has empty variable []. You can put name of specific file you want to proceed. If empty program will process every file in current directory by specific postfix.


%}
dirf = 'C:\Users\Arshat\Documents\MATLAB\forgithub\data';




makemat(dirf);
%It converts gif images to matlab matrixes format. The result will be <youprefix>orig.mat. In case abouve name will be fristatemporig.mat file


aver = 30; %relates to on time parameters averaging, 
low = 7; %Low edge of highpass filter
high = 80; %high edge of lowpass filter
video=0; %1 with visualisation, 0 without visualisation (allows to make video file on result of preprocessing (doesn’t work correctly on different system)
makedata(aver,high,low,video,[]);% preprocessing of data, filtering using aver,high,low,video paramters 


tres = 80; %-local treshold, low limit of considering.
G = 30; %-  Gradient limit of considering
maketsegment( tres,G,[]); %making topological object using parameters tres and G. Result has postfix <>segment.mat. 

tmax = 5; %relate to minimal dimension of object to be considered. The object with time dimension less than 5 will be wasted from consideration. 
volex = 0.9;%relates to topological characteristic of presents/absence of slope of pillar like object.
makecut(tmax,volex,[]); %Cut segments on simple complex,



carea = 3; %adding to consideration addition area equal 3 pixels.
video=0; %graphical output/ video = 1 on, video = 0 -off. video = 1 significantly increase calculation time.
makechoose(tmax,carea,video,[]);%This script choose comets base on its form.

tr = 0.05:0.05:0.5;% treshold
dr =5:25; %blurring (or width of Aire circle) 
kr =3:0.2:30;%tail length of comet
cr = 40:0.5:50;%shift between max of intensity and tip of tube.
makelenght(tr,dr,kr,cr, [] ); %finds all parameters of commet relates to regression analisis: tail length, bluring, shifts between maximum of intensity and tip, and threshold:
