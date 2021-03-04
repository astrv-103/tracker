function [out] = cuttnode (name)

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
  if (p(i).BoundingBox(6)>=7)&&(p(i).FilledArea/p(i).BoundingBox(4)/p(i).BoundingBox(5)/p(i).BoundingBox(6))<0.9
      
      pfb = zeros(size(p(i).PixelList));
      pfb(:,1) = p(i).PixelList(:,2) + minx-1;%+floor(p(i).BoundingBox(2));
      pfb(:,2) = p(i).PixelList(:,1) + miny-1;%+floor(p(i).BoundingBox(1));
      pfb(:,3) = p(i).PixelList(:,3) + minz-1;%+floor(p(i).BoundingBox(3));
     
      csvwrite(['outcut' num2str(num)],pfb);
      prop(num,1) = minz+p(i).BoundingBox(3);
      prop(num,2) = minz+p(i).BoundingBox(3)+p(i).BoundingBox(6);
      num=num+1;
 
      
  end

end



%


