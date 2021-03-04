clear all
am = dir('*outline.mat');
n = 0;
dr = 0;
gfk = 1;
for j = 1:length(am)
    load(am(j).name);
    namereal = am(j).name;
     
    for i = 1:(length(nodedata)-1)
        cass =  corrcoef(nodedata(i).alls,nodedata(i).allk);
        cass2 =  corrcoef(nodedata(i+1).alls,nodedata(i+1).allk);
        
        if nodedata(i).asl == nodedata(i+1).asl && nodedata(i).z == nodedata(i+1).z-1 ...
         && 1-cass(2,1)<0.01 && 1-cass2(2,1)<0.03 ... 
       %  && nodedata(i+1).crm == nodedata(i).crm
        
     %&& nodedata(i).miner<0.03 && nodedata(i+1).miner<0.9 ...
           
            
     
        %&& abs(nodedata(i+1).krm - nodedata(i).krm)/nodedata(i).krm<0.2
            
            %angle1 = angle(nodedata(i+1).corcc - nodedata(i).corcc);
            
             corcx = real(nodedata(i).corccr)+(50 -  nodedata(i).crm)*0.5*cos( nodedata(i).anglreal);
             corcy = imag(nodedata(i).corccr)+(50 -  nodedata(i).crm)*0.5*sin( nodedata(i).anglreal);
             corcc1 = corcx+sqrt(-1)*corcy;
             corcx = real(nodedata(i+1).corccr)+(50 -  nodedata(i+1).crm)*0.5*cos( nodedata(i+1).anglreal);
             corcy = imag(nodedata(i+1).corccr)+(50 -  nodedata(i+1).crm)*0.5*sin( nodedata(i+1).anglreal);
             corcc2 = corcx+sqrt(-1)*corcy;
            angle1 = angle(corcc2 - corcc1);
           
            angle2 = angle(nodedata(i+1).corccr - nodedata(i).corccr);
            angle3 = nodedata(i).anglreal;
            fun = abs(sin(angle1) - sin(angle3))+abs(cos(angle1) - cos(angle3));
            %fun = abs(sin(angle2) - sin(angle3))+abs(cos(angle2) - cos(angle3));
            testa = nodedata(i).alls/max(nodedata(i).alls);
            lent = length(testa);
            k = max(abs(testa(1:lent -1) -testa(2:lent)));
            if fun<0.3 
                n = n+1;
                vyt(n) =nodedata(i).krm;
                vel2(n) = abs(nodedata(i+1).corccr - nodedata(i).corccr)+((50-nodedata(i+1).crm) - (50-nodedata(i).crm))/2; 
                
                del(n) = (nodedata(i+1).krm - nodedata(i).krm);%/nodedata(i).krm*100 ;
                %del(n) = (-nodedata(i+1).crm+nodedata(i).crm);%/nodedata(i).krm*100 ;
                
                asl(n)= nodedata(i).asl;
                i_n(n)= i;
                vel(n) = abs(corcc2 - corcc1);
                
                
               % if vel2(n)/vyt(n)>2/10
               % figure(1)
               % surf(nodedata(i).orig);
               % set(gca,'view',[0 90]);
               % figure(2)
               % surf(nodedata(i).plane);
               % set(gca,'view',[0 90]);


               % figure(3)
               % plot(1:length(nodedata(i).alls),nodedata(i).alls/max(nodedata(i).alls),1:length(nodedata(i).alls),nodedata(i).allk/max(nodedata(i).allk))
               % afv = struct('orig',nodedata(i).orig,'x',1:length(nodedata(i).alls),'y1',nodedata(i).alls/max(nodedata(i).alls),'y2',nodedata(i).allk/max(nodedata(i).allk),'k',nodedata(i).krm,'t',nodedata(i).trm,'c',nodedata(i).crm,'m',nodedata(i).miner,'d',nodedata(i).drm);
               % pause
               
                    
                    
             %   end
                 if abs(nodedata(i+1).krm - nodedata(i).krm)<1   %nodedata(i).krm
                     dr = dr+1;
                     vel_(dr) = vel(n);
                     vel2_(dr) = vel2(n);
                     vyt_(dr) = vyt(n);
                 end  
                %pause
            end
        end
    end
   % figure(1)
   
    %plot(tail,vel,'o');
    %dr = 0;
    %tail = [];
    %vel = [];
    

end
%figure(1)
%plot(vyt,vel2,'o',tail,vel,'o');
%plot(vyt,vel2,'o');

result = [vyt',vel2'];
%[a,b]=hist(del,50);

%hist(del,30);
n = 1;
for i = 1:length(vel2)-1
    if asl(i) == asl(i+1) &&  i_n(i) ==  i_n(i+1) - 1
        veldist(n) = vel2(i+1) - vel2(i);
        taldis(n) = vyt(i+1) - vyt(i);
        n = n+1;
    end
end
gg = zeros(max(vyt_),1);
nums= zeros(max(vyt_),1);
for i = 1:length(vyt_)
    k = vyt_(i);
    nums(k) = nums(k)+1;
    gg(k) = gg(k)+vel2_(i);
end
gg = gg./nums;
figure(4)
plot(vyt,vel2,'o',1:max(vyt),gg);


%veldist = vel2;
%asdf = histogram(veldist,round((max(veldist) - min(veldist))/0.2))

%veldist = vyt;
%asdf = histogram(veldist)
%asdf.BinEdges(2)-asdf.BinEdges(1)
%delx = asdf.BinEdges(1:end-1)+(asdf.BinEdges(2)-asdf.BinEdges(1))/2;
%dely = asdf.Values;
%plot(delx,dely);
%delresult = [delx',dely'];
