function makechoose( tmax,carea,video,name)
%MAKECHOOSE Summary of this function goes here
%   Detailed explanation goes here

if isempty(name) == 1 
       dirf = dir('*cuted.mat');
       for i = 1:length(dirf)
           dirf(i).name
           makechoosv(dirf(i).name,tmax,carea,video);
       end
   else
         makechoosv(name,tmax,carea,video); 
 end

end

function makechoosv(namereal,tmax,carea, video)
load(namereal);
name = namereal(1:end-9);
load([name 'filter.mat']);
[qwe,qwr,qwt] = size(mat);
nodd = 0;
for asl = 1:length(outcut)
    node = outcut(asl).outcut;
    node=node+1;
    
    [q,w] = size(node);


    maxz = max(node(:,3));
    minz = min(node(:,3));
    if (maxz-minz)>tmax
        
        
        for z = minz:maxz
            flaguse =0;
            xp = node(node(:,3) ==z,1);
            yp = node(node(:,3) ==z,2);
            maxxp = min( [max(xp)+carea, qwe]);
            minxp = max([min(xp)-carea, 1]);
            maxyp = min([max(yp)+carea , qwr]);
            minyp = max([min(yp)-carea , 1]);
            plane = zeros(maxxp - minxp+1,maxyp - minyp+1);
            for i = 1:length(xp)
                plane(xp(i)-minxp+1,yp(i)-minyp+1) = 1;
            end
            orig = mat(minxp:maxxp,minyp:maxyp,z);
            [as,sa] = size(orig);
            [Xq,Yq] = meshgrid(1:0.1:as,1:0.1:sa);
            V = interp2(orig,Xq,Yq,'cubic');
            [qv,wv] = size(V);
            maxValue = max(V(:));
            [rows, cols] = find(V == maxValue);
            lim = max([(qv - rows(1)),rows(1),(wv - cols(1)), cols(1)]);
            
            r = 0;
            n = 1;
            out = zeros(33,50);
            while (r<lim)
                for i = 1:32
                    ang = 2*pi/32*(i-1);
                    xb = floor(rows(1)+r*cos(ang));
                    yb = floor(cols(1)+r*sin(ang));
                    if xb > 1 && xb <qv  && yb>1 && yb<wv && n<=50
                        out(i,n) = V(xb,yb)*(V(xb,yb)>5);
                        
                    end
                
                end
                r = r +5;
                n = n+1;
                
                
            end
          
            if (sum(sum(plane))<30)
                flaguse =1;
            end
            
            for i = 1:32
                m1 = out(i,1:49);
                m2 = out(i,2:50);
                k = m1 - m2;
                if sum(k<0)>0
                    flaguse =1;
                end
            end
            [bun,numer] = max(sum(out'));
            angmax = changeangl(2*pi/32*(numer-1));

            anglreal = changeangl(angmax+pi); 

            numhead = round(changeangl(anglreal)*32/2/pi+1);
            numtale = round(changeangl(anglreal+pi)* 32/2/pi+1);
            numright = round(changeangl(anglreal+pi/2)* 32/2/pi+1);
            numleft = round(changeangl(anglreal-pi/2)* 32/2/pi+1);
            numright1 = round(changeangl(anglreal+pi/4)* 32/2/pi+1);
            numleft1 = round(changeangl(anglreal-pi/4)* 32/2/pi+1);
            out(33,:) = out(1,:);
            out(isnan(out)) = 0;
            arrhead = out(numhead,:);
            arrtale = out(numtale,:);
            arrleft = out(numright,:);
            arrright = out(numleft,:);
            arrleft1 = out(numright1,:);
            arrright1 = out(numleft1,:);
            if sum(abs(arrleft1 - arrright1))/length(arrleft1)/max(arrleft1)>0.02 || sum(abs(arrleft - arrright))/length(arrleft)/max(arrleft)>0.02;
               flaguse = 1; 
            end
            alls = [arrhead(length(arrhead):-1:1),arrtale];
             if sum(alls)<40
                flaguse =1;
             end
            

            
            if flaguse ==0
                
               if video==1
                    figure(1)
                    surf(orig);
                    set(gca,'view',[0 90]);
                    figure(4)
                    surf(plane);
                    set(gca,'view',[0 90]);
                    pause(1)

                    figure(2)
                    plot(out(1,:)/max(out(i,:)));
                    hold on

                    for i = 1:1:32

                      plot(out(i,:)/max(out(i,:)));

                    end
                    hold off
                    pause(0.1);
               end
             
                corcxr = minxp+rows(1)/10;
                corcyr = minyp+cols(1)/10;
                
                nodd=nodd+1;
                nodedata(nodd) = struct('out',out,'node',node,'asl',asl,'z',z,'corccr',corcxr+sqrt(-1)*corcyr,'plane',plane,'orig',orig,'alls',alls,'anglreal',anglreal);
                
            end
            
    
            
        end
 
        
        
        
    end
    disp(['Number  = ' num2str(asl)])
end
save([name 'select.mat'],'nodedata');
end

function [ args ] = changeangl( angle )
    args = rem(angle,2*pi);
    if args<0
        args = args+2*pi;
    end
end