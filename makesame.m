function [kgla] = makesame(p,q,w)

ajk = double(p.Image);
x1 = floor(p.BoundingBox(1))+1;
y1= floor(p.BoundingBox(2))+1;
x2 = x1+floor(p.BoundingBox(3))-1;
y2= y1+floor(p.BoundingBox(4))-1;
kgla=zeros(q,w);
kgla(y1:y2,x1:x2) =( ajk );
end
                    