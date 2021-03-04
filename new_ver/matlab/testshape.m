x = 1:0.1:200;

dr = 12;
kr = 15;
tr = 0.1;
cr = 60;
n = 1;
%{   
shift=5;
    f1 = cometfun(x,dr,kr,tr,cr );
    
    f2 = cometfun(x,dr,kr +shift,tr,cr-20 );
    [a1,b1] = max(f1);
    [a2,b2] = max(f2);
    x(b1) -cr 
    x(b2) -cr +20 
    (x(b2)-x(b1)) 
    plot(x,f1,x,f2);
    
%}
for shift = -10:10
    f1 = cometfun(x,dr,kr,tr,cr );
    
    f2 = cometfun(x,dr,kr +shift,tr,cr-20 );
    
    [a1,b1] = max(f1);
    [a2,b2] = max(f2);
    real(n) = (x(b2)-x(b1));
    n = n+1;
    %figure(1)
    %plot(x,f1,x,f2);
    %pause
end

%figure(2)
plot(-10:10,real)
