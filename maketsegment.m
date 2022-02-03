function maketsegment( tres,G,name )
    if isempty(name) == 1 
        dirf = dir('*filter.mat');
        for i = 1:length(dirf)
           makesegmentV(dirf(i).name,tres,G);
       end
    else 
        makesegmentV(name,tres,G);
    end


end

function makesegmentV(name,tres,G)
    load(name);
     nameout = name(1:end-10);
     [a,b,c,d] = test(double(mat),tres,G);
     for i = 1 : max(d)
         segments(i) = struct('out',[a(d==i)  b(d==i)  c(d==i)]);
     end
     save([nameout, 'segment.mat'], 'segments');
    
end