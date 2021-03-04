
function makedata(aver,high,low,video,name)
   if isempty(name) == 1 
       dirf = dir('*orig.mat');
       for i = 1:length(dirf)
           makedataV(dirf(i).name,aver,high,low,video);
       end
   else
         makedataV(name,aver,high,low,video); 
   end


end



function makedataV(name,aver,high,low,video)
    load(name);
    [q,w,mp] = size(alls);
    nameout = name(1:end-8);
    alsq = zeros(max([q,w]),max([q,w]),mp);
    alsq(1:q,1:w,1:mp) = alls;
    alls = alsq;
    [q,w,mp] = size(alls);

    allsbuf=zeros(q,w,mp,'single');

    for i = 1:mp;
        alls(:,:,i) = filter2d(alls(:,:,i),high,low);
    end


    for i=1:aver
        allsbuf(:,:,i) = sum(alls(:,:,i:(i+aver-1)),3)/aver;
    end
    for i=aver+1:mp
        allsbuf(:,:,i) = sum(alls(:,:,(i-aver):(i-1)),3)/aver;
    end

    mat = alls - allsbuf;

    mat(mat<0) = 0;

    save([nameout 'filter.mat'],'mat');
    if video == 1 
        v = VideoWriter([name '.avi']);
        v.FrameRate = 3; 
        open(v);

        axis tight manual 
        set(gca,'nextplot','replacechildren'); 
        [q,w,b] = size(mat);
        for i=1:b
            maxcv = max(max(mat(:,:,16)));
            out = mat(:,:,i)/maxcv;
            imshow(out);

            disp(['Number of laver = ' , num2str(i)]);
            frame = getframe(gcf);
            writeVideo(v,frame);


        end
        close(v);
    end
end
function [ res ] = filter2d(I,d,d2 )
    ff=fft2(I);
    [q,w] = size(ff);
    [X,Y]=meshgrid(1:q,1:w);
    d3=1/2;
    g=exp(-(q/2-X).*(q/2-X)/d/d).*exp(-(w/2-Y).*(w/2-Y)/d/d)-exp(-(q/2-X).*(q/2-X)/d2/d2).*exp(-(w/2-Y).*(w/2-Y)/d2/d2);
    %kx = exp(-(q/2-X).*(q/2-X)/d3/d3).*exp(-(w/2-Y).*(w/2-Y)/d3/d3);
    %kx=kx/max(max(kx));
    %g=g+kx;
    kll = ifftshift(g);
    res =real(ifft2(( ff.*kll)));
end


