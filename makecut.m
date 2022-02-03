
function makecut(tmax,volex,name)
    if isempty(name) == 1 
       dirf = dir('*segment.mat');
       for i = 1:length(dirf)
           
           makecutn(dirf(i).name,tmax,volex);
       end
   else
         makecutn(name,tmax,volex); 
   end

end


function makecutn(name,tmax,volex)
    load(name);
    namereal = name(1:end - 11);
    n=1;
    
    for i = 1:length(segments)
    
    
        fftm = cutarea(segments(i).out,tmax,volex);
        for i = 1:length(fftm)
            outcut(n) = struct('outcut',fftm(i).pfb);
            n=n+1;
        end
    end
    save([namereal, 'cuted'], 'outcut');
    disp(['file name = ', namereal ' number = ', num2str(n)] );
end




function [ out ] = cutarea( node,tmax,volex )
    numb = 1;
    [q,w] = size(node);
    maxx = max(node(:,1));
    minx = min(node(:,1));
    maxy = max(node(:,2));
    miny = min(node(:,2));
    maxz = max(node(:,3));
    minz = min(node(:,3));
    g = zeros(maxx-minx+1,maxy-miny+1,maxz-minz+1);

    for i = 1:q
        g(node(i,1) - minx+1,node(i,2) - miny+1,node(i,3) - minz+1) =1;
    end
    gbaz = g;

    for z =  1:(maxz-minz)
        s1 = gbaz(:,:,z);
        s2 = gbaz(:,:,z+1);
        [sizes1x,sizes1y] = size(s1);
        kv1 = bwlabel(s1,4);
        kv2 = bwlabel(s2,4);
        p1=regionprops(kv1,'PixelList','FilledImage','BoundingBox','Image');
        p2=regionprops(kv2,'PixelList','FilledImage','BoundingBox','Image');
        for i = 1:length(p1)
            count = 0;
            for f = 1: length(p2)
               kmp2 = makesame(p2(f),sizes1x,sizes1y);
               kmp1 = makesame(p1(i),sizes1x,sizes1y);
               if(sum(sum(kmp1.*kmp2)))>0
                   count=count+1;
               end
            end
            if (count>=2)
                g(:,:,z) = g(:,:,z).*abs(kmp1-1);                       
            end
        end
        for i = 1:length(p2)
            count = 0;
            for f = 1: length(p1)
               kmp2 = makesame(p1(f),sizes1x,sizes1y);
               kmp1 = makesame(p2(i),sizes1x,sizes1y);
               if(sum(sum(kmp1.*kmp2)))>0
                   count=count+1;
               end
            end
            if (count>=2)
                g(:,:,z+1) = g(:,:,z+1).*abs(kmp1-1);                       
            end
        end
    end

    p = regionprops(bwlabeln(g,6),'FilledImage','BoundingBox','FilledArea','PixelList');
    for i = 1:length(p)
      if (p(i).BoundingBox(6)>=tmax)&&(p(i).FilledArea/p(i).BoundingBox(4)/p(i).BoundingBox(5)/p(i).BoundingBox(6))<volex

          pfb = zeros(size(p(i).PixelList));
          pfb(:,1) = p(i).PixelList(:,2) + minx-1;
          pfb(:,2) = p(i).PixelList(:,1) + miny-1;
          pfb(:,3) = p(i).PixelList(:,3) + minz-1;
          out(numb) =  struct('pfb',pfb);
          numb=numb+1;
       end
    end
    if numb == 1
        out = [];
    end
end

