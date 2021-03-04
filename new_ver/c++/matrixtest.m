
 [a,b,c,d] = test(double(out));
 
 for i = 1 : max(d)
      
    out(i) = struct('out',[a(d==i)  b(d==i)  c(d==i)]);
    
    
 end
 