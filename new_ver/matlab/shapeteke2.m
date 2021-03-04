%function [trm,drm,krm, crm, miner] = shapeteke2( alls )
%SHAPETEKE Summary of this function goes here
%   Detailed explanation goes here
clear all
dirf = dir('*outline.mat');

load(dirf(1).name);
alls = nodedata(1).alls;
alls = alls / max(alls);

    afg = sum(alls>0);
    tr = 0.1:0.1:0.4;
    dr =6:12;
    kr =3:35;
    cr = 40:0.5:50;
    alls_test = cometfun(1:length(alls),dr(3),kr(12),tr(1),cr(3));
    out = zeros(length(tr),length(dr),length(kr),length(cr),length(alls));
    outf = zeros(length(tr),length(dr),length(kr),length(cr),length(alls));
    
    for tr_ = 1:length(tr)
        for dr_ =1:length(dr)
            for kr_ =1:length(kr)
                for cr_ = 1:length(cr)
                    
                    out(tr_,dr_,kr_,cr_,1:length(alls)) = cometfun(1:length(alls),dr(dr_),kr(kr_),tr(tr_),cr(cr_) );
                end
            end
        end
    end
    [q,w,e,r,t] = size(out);
  
    for m = 1:length(nodedata)
        %alls = alls_test.*(alls_test>0.2);%nodedata(m).alls/max(alls);
        alls = nodedata(m).alls/max(nodedata(m).alls);
    
        for i = 1: length(alls)
            outf(:,:,:,:,i) = alls(i); 
        end
        afg = sum(alls>0);
        
        a = sum(abs(out.*(outf>0) - outf),5)/afg;

        [minM idx] = min(a(:));
        [tr_m dr_m kr_m cr_m ] = ind2sub(size(a),idx);
        [trm1,drm1,krm1, crm1, miner1] = shapeteke( alls );
        figure(1)
        plot(1:length(alls),alls/max(alls),1:length(alls),cometfun(1:length(alls),dr(dr_m),kr(kr_m),tr(tr_m),cr(cr_m)), ...
            1:length(alls),cometfun(1:length(alls),drm1,krm1,trm1,crm1));
        
        
        pause
        
    end
    
    
    
%end