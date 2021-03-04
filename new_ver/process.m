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
        % && abs(nodedata(i+1).crm - nodedata(i).crm)<1  
     
        % && nodedata(i+1).crm == nodedata(i).crm 
       
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
             vel_real(n) = abs(corcc2 - corcc1);
             vel_real_s(n) = abs(nodedata(i+1).corccr - nodedata(i).corccr)+((50-nodedata(i+1).crm) - (50-nodedata(i).crm))/2; 
             vel_max(n) = abs(nodedata(i+1).corccr - nodedata(i).corccr);
             delL(n) = (nodedata(i+1).krm - nodedata(i).krm);
             delK(n) = (-nodedata(i+1).crm+nodedata(i).crm);
             L(n) = (nodedata(i).krm );
             C(n) = (nodedata(i).crm );
             asl(n)= nodedata(i).asl;
             i_n(n)= i;
             
              
             if abs(nodedata(i+1).krm - nodedata(i).krm)<1   %nodedata(i).krm
                 dr = dr+1;
                 vel_real_(dr) = vel_real(n);
                 vel_max_(dr) = vel_max(n);
                 L_(dr) = L(n);
             end
         end
        end
    end
    
end
gg = zeros(max(L),1);
nums= zeros(max(L),1);
for i = 1:length(L)
    k = L(i);
    nums(k) = nums(k)+1;
    gg(k) = gg(k)+vel_max(i);
end
gg = gg./nums;
figure(1);plot(L,vel_real,'o',1:max(L),gg);xlabel('L - tail length');ylabel('Velosity');


figure(3)
hist3([L ;vel_real_s]',[25,30],'CDataMode','auto','FaceColor','interp');view(2);xlabel('L - tail length'); ylabel('Shift between vaximum and tube end')

[a,c] = hist3([L ;vel_real]',[25,30]);

for i = 1:25
    a(i,:) = a(i,:)/max(a(i,:));
end




%figure(3)
%hist3([L ;50-C]',[30,15],'CDataMode','auto','FaceColor','interp');view(2);xlabel('L - tail length'); ylabel('Shift between vaximum and tube end')


%figure(4)
%hist3([L ;delK]',[30,15],'CDataMode','auto','FaceColor','interp');view(2);xlabel('L - tail length');ylabel('Delta tail')


