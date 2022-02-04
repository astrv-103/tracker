# Tracker

Should note several thing:
1. Developing of this tracker was aimed to achieve reliability. Topological methods allows us to consider all properties of comet (spatial or time) as whole thing.
2. By tracker we found correlation between comets tail and velocity. However, it also mean that we have proof that our tracker works correctly (more or less). Because if you see no correlation it does not mean it does not exist. It can mean that tracker is not capable to find it. In this case, there can be possibility that all data obtained by tracker can be wrong. In our case we sure in reliability of our tracker.
3. Result of using this tracker was published: https://www.frontiersin.org/articles/10.3389/fmolb.2021.745089/full
4. This tracker allows to find greate range of comet properties (statistical or dynamic) not only velocity and tail. I am ready to cooperate. If you need anything, just let me know.



Code is devoted to accurate tracking biological objects comets. These objects are part of cell skeleton. This program takes as input sequence of microscope images. It allows finding dependence of comet tail length of comet on it velocity. Code consists of matlab scripts and using standard matlab functions, but main function related to topology was developed by c++ code and mex matlab functional. Workability was tested only for windows and matlab version higher than 2017a, but we did running this code on matlab in ubuntu ver 20.04. So far this code works correctly only with our microscopic images. If you want to use your own images, there is possible the adjustment of parameters will be required. Without this correct work of this code is not guaranteed.

You can download test data of comets images: (reference : https://disk.yandex.ru/d/LtyWWTgLprQXLA) 

To install just copy files to your directory. The mainscript.m is file that contain all function and routing for compilation. This code is work with sequences of microscopic images with .GIF file extension. The dirf variable is related to file path to you data directory. Should note that program deals with sequences of directoties. Each directory must contain sequence of GIF images. If you have only one sequence, make separate directory and put your sequence in this directory. So all paths to you gif images must be like: …./data/fistatemp/1file.gif Program allows to work with several data directories: …/data/secondatemp …/data/thirdatemp In this case program will process all data and file of result will have prefix “firstatemp”, “secondatemp” and so on related to directory name.
dirf variable is a string contains related to data path. Change this variable to you file path: dirf = 'd:/work/youdatapath';

In this case path to any of gif image must be like d:/work/youdatapath/fristatemp/1.gif As we said will be prefix. And all output files will be fristatemp<…>.mat Mainscript consist of several function – routing. After every routing result will be saved in file with special postfix. It allows to not lost all process data if calculation will be stop. Almost every function – routing has empty variable []. You can put name of specific file you want to proceed. If empty program will process every file in current directory by specific postfix. First routing is makemat(dirf); It converts gif images to matlab matrixes format. The result will be orig.mat. In case abouve name will be fristatemporig.mat file Next routing make preprocess of data(filtering makedata(aver,high,low,video,[])

In takes several variables: Aver = 30; relates to on time parameters averaging, low = 7; (Low edge of highpass filter) high = 80; (high edge of lowpass filter) video=0; 1 with visualisation, 0 without visualisation (allows to make video file on result of preprocessing (doesn’t work correctly on different system) Result will be file with postfix <>filte.mat Next routing is maketsegment( tres,G,[]) making topological object. Result has postfix <>segment.mat. It takes two variables: tres = 80; -local treshold, low limit of considering. G = 70 - Gradient limit of considering

Next routing: makecut(tmax,volex,[]); Cut segments on simple complex, It takes two parameters: tmax = 5; volex = 0.9; tmax – relate to minimal dimension of object to be considered. The object with time dimension less than 5 will be wasted from consideration. Volex = 0.9 relates to topological characteristic of presents/absence of slope of pillar like object. Postfix of result file will be ‘cuted.mat’

Routing makechoose(tmax,carea,[]);takes two parameters: tmax same as previous routing. Carea =3 – adding to consideration addition area equal 3 pixels. Postfix will be “selected.mat” This script choose comets base on its form.

Next routing finds all parameters of commet relates to regression analisis: tail length, bluring, shifts between maximum of intensity and tip, and threshold: makelenght(tr,dr,kr,cr, [] )

It takes all parameters as vectors: tr = 0.1:0.05:0.4; dr =6:18; kr =3:0.2:30; cr = 40:0.2:50;

It defines at the same time area and precession of regressing analisys: for threshold tr it will find result between 0.1 and 0.4 with precision 0.05. Same way will be for dr – blurring (or width of Aire circle) kr – tail length of comet cr – shift between max of intensity and tip of tube. Resultfile will have postfix “outline.mat”

This file will be final result: it contains all data needed for finding correlation between velocity and tail length.

Script processref.mat will process all data to find correlation. It will find all result file with postfix “outline.mat” and processed its. Result will be drawing of tail length – velocity dependence and decoration time.
