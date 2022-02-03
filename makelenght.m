function  makelenght(tr,dr,kr,cr,name)
%MAKELENGHT Summary of this function goes here
%   Detailed explanation goes here
 if isempty(name) == 1 
     dirf = dir('*select.mat');
     load(dirf(1).name);
 else
     load(name);
 end
 alls = nodedata(1).alls;
 alls = alls / max(alls);
 
    afg = sum(alls>0);
    %tr = 0.1:0.1:0.4;
    %dr =6:12;
    %kr =3:35;
    %cr = 40:0.5:50;
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
  
  disp('start')  
  if isempty(name) == 1 
     dirf = dir('*select.mat');
     for lk = 1:length(dirf)
         load(dirf(lk).name);
         for m = 1:length(nodedata)
            alls = nodedata(m).alls/max(nodedata(m).alls);
            for i = 1: length(alls)
                outf(:,:,:,:,i) = alls(i); 
            end
            afg = sum(alls>0);
            a = sum(abs(out.*(outf>0) - outf),5)/afg;
            [minM, idx] = min(a(:));
            [tr_m, dr_m, kr_m, cr_m ] = ind2sub(size(a),idx);
            %figure(1)
            %plot(1:length(alls),alls/max(alls),1:length(alls),cometfun(1:length(alls),dr(dr_m),kr(kr_m),tr(tr_m),cr(cr_m)));
            %pause(0.1)
            nodedata(m).krm=kr(kr_m);
            nodedata(m).trm=tr(tr_m);
            nodedata(m).crm= cr(cr_m);
            nodedata(m).miner= minM;
            nodedata(m).allk= cometfun(1:length(alls),dr(dr_m),kr(kr_m),tr(tr_m),cr(cr_m));
            nodedata(m).drm= dr(dr_m);
            disp(['Number  = ' num2str(m)])
         end
         save([dirf(lk).name(1:end - 10) 'outline.mat'],'nodedata');
     end
  else
    load(name);
    for m = 1:length(nodedata)
       
        alls = nodedata(m).alls/max(nodedata(m).alls);
    
        for i = 1: length(alls)
            outf(:,:,:,:,i) = alls(i); 
        end
        afg = sum(alls>0);
        
        a = sum(abs(out.*(outf>0) - outf),5)/afg;

        [minM, idx] = min(a(:));
        [tr_m, dr_m, kr_m, cr_m ] = ind2sub(size(a),idx);
        %figure(1)
        %plot(1:length(alls),alls/max(alls),1:length(alls),cometfun(1:length(alls),dr(dr_m),kr(kr_m),tr(tr_m),cr(cr_m)));   
        %pause(0.1)
        nodedata(m).krm=kr(kr_m);
        nodedata(m).trm=tr(tr_m);
        nodedata(m).crm= cr(cr_m);
        nodedata(m).miner= minM;
        nodedata(m).allk= cometfun(1:length(alls),dr(dr_m),kr(kr_m),tr(tr_m),cr(cr_m));
        nodedata(m).drm= dr(dr_m);
        
    end
    save([name(1:end - 10) 'outline.mat'],'nodedata');
 end
end

