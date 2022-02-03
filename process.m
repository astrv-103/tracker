%{

Script process.mat will process all data to find correlation. 
It will find all result file with postfix “outline.mat” and processed its. 
Result will be drawing of tail length – velocity dependence and decoration time.

%}


clear all
close all

gfk = 4;

am = dir('*outline.mat');
n = 0;
dr = 0;
for j = 1:length(am)
    load(am(j).name);
    namereal = am(j).name;
     
    for i = 1:(length(nodedata)-gfk-1)
        cass =  corrcoef(nodedata(i).alls,nodedata(i).allk);
        cass2 =  corrcoef(nodedata(i+1).alls,nodedata(i+1).allk);
        
        if nodedata(i).asl == nodedata(i+gfk).asl && nodedata(i).z == nodedata(i+gfk).z-gfk ...
         && 1-cass(2,1)<0.03 && 1-cass2(2,1)<0.03 ...
     
         corcx = real(nodedata(i).corccr)+(50 -  nodedata(i).crm)*0.5*cos( nodedata(i).anglreal);
         corcy = imag(nodedata(i).corccr)+(50 -  nodedata(i).crm)*0.5*sin( nodedata(i).anglreal);
         corcc1 = corcx+sqrt(-1)*corcy;
         corcx = real(nodedata(i+gfk).corccr)+(50 -  nodedata(i+gfk).crm)*0.5*cos( nodedata(i+gfk).anglreal);
         corcy = imag(nodedata(i+gfk).corccr)+(50 -  nodedata(i+gfk).crm)*0.5*sin( nodedata(i+gfk).anglreal);
         corcc2 = corcx+sqrt(-1)*corcy;
         angle1 = angle(corcc2 - corcc1);
         angle2 = angle(nodedata(i+gfk).corccr - nodedata(i).corccr);
         angle3 = nodedata(i).anglreal;
         angle4 = nodedata(i+gfk).anglreal;
         
         fun = abs(sin(angle1) - sin(angle3))+abs(cos(angle1) - cos(angle3));
         fun3 = abs(sin(angle1) - sin(angle4))+abs(cos(angle1) - cos(angle4));
         %fun = abs(wrapToPi(angle1-angle3));
         %fun2 = abs(wrapToPi(angle1-angle4)); 
         L_traj = [nodedata(i+gfk).krm, nodedata(i).krm];
         
         if fun<0.3 %&& fun3<0.3 && std(L_traj)<0.3*sum(L_traj)/length(L_traj) 
             n = n+1;
            
             vel_real(n) = abs(corcc2 - corcc1);
             vel_real_s(n) = abs(nodedata(i+gfk).corccr - nodedata(i).corccr)+((50-nodedata(i+gfk).crm) - (50-nodedata(i).crm))/2; 
             vel_max(n) = abs(nodedata(i+gfk).corccr - nodedata(i).corccr);
             delL(n) = (nodedata(i+gfk).krm - nodedata(i).krm);
             
             delK(n) = nodedata(i).drm;
             
             L(n) = (nodedata(i+gfk).krm );
             L1(n) = (nodedata(i).krm );
             
             C(n) = (nodedata(i).crm );
             asl(n)= nodedata(i).asl;
                    
             i_n(n)= i;
             %if nodedata(i).asl == nodedata(i+gfk+1).asl && nodedata(i).z == nodedata(i+gfk+1).z-gfk-1
             %    if 1-nodedata(i+gfk+1).corr<0.03
             %        dr=dr+1;
             %        vel3(dr)=vel_real(n);
             %        L3(dr)= (nodedata(i+gfk+1).krm );
                 
             %    end
             
             %end
         
            
             
             
             
              
           
         end
        end
    end
    
end



t = (L/2)';
y = (vel_real/gfk)';


%t = (L3(1:770)/2)';
%y = (vel3(1:770)/gfk)';


R = corrcoef(t,y); 
F = @(x,xdata)x(1)*xdata;
x0 = 0;
[x,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,t,y);
plot(t,y,'o',t,x(1)*t);
title(['Dependence velocity of comet on taillengtht: velocity ' num2str(gfk) ' time discrets']);
xlabel('taillength [pixel size]') 
ylabel('Velosity [pixel size/time discrete')
legend({['data coefficient of correlation =' num2str(R(1,2)) ],['linear aproximation - decoration time =' num2str(1/x(1)) ]},'Location','northwest')


