clear all
am = dir('*outlinep.mat');
for i = 1:length(am)
    load(am(i).name);
    for k = 1:length(nodedata)
        [trm,drm,krm, crm, miner] = shapeteke( nodedata(k).alls );
        allk = cometfun(1:length(nodedata(k).alls),drm,krm,trm,crm );         
        figure(3)
        plot(1:length(nodedata(k).alls),nodedata(k).alls/max(nodedata(k).alls),1:length(nodedata(k).alls),allk/max(allk))
        nodedata(k).drm=drm;
        nodedata(k).krm=krm;
        nodedata(k).trm=trm;
        nodedata(k).crm= crm;
        nodedata(k).miner= miner;
        nodedata(k).allk= allk;
        
        pause(0.1);
    end
    name =am(i).name(1:length(am(i).name)-12);
    
    save([name 'outline.mat'],'nodedata');
end
