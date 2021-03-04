am = dir('*filter.mat');
for i = 4:length(am)
    load(am(i).name)
    maxcv = max(max(mat(:,:,16)));
    [q,w,e] = size(mat);
    for z = 1:e
       
       
                   buf = mat(:,:,z);
                   buf(buf<0) = 0;
                   [av,va] = histtressim(buf);
            out = buf/maxcv;
            %figure(1)
            %imshow(out);
            figure(2)
            plot(va(va<10),av(va<10));
            pause(0.1)
            
    end
        
        
       
       
    
    pause
end