function [ out] = cometfun(x,d,k,t,c)
out = zeros(size(x));

for i =1 : length(x)
    out = out + ((i-c)>0).*exp(-(i-c)/k).*exp(-(x-i).*(x-i)/d/d);
    
    
end
max(out);
out = out/max(out);
out = out-t;
out(out<0) = 0;
out = out/max(out);
 
   
%COMMTEST Summary of this function goes here
%   Detailed explanation goes here


end

