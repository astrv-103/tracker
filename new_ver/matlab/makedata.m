function makedata(name)
load([name 'orig.mat']);
[q,w,mp] = size(alls);
alsq = zeros(max([q,w]),max([q,w]),mp);
alsq(1:q,1:w,1:mp) = alls;
alls = alsq;
[q,w,mp] = size(alls);

allsbuf=zeros(q,w,mp,'single');

for i = 1:mp;
    alls(:,:,i) = filter2d(alls(:,:,i),80,7);
end
aver = 30;

for i=1:aver
    allsbuf(:,:,i) = sum(alls(:,:,i:(i+aver-1)),3)/aver;
end
for i=aver+1:mp
    allsbuf(:,:,i) = sum(alls(:,:,(i-aver):(i-1)),3)/aver;
end

mat = alls - allsbuf;
%mat = alls;

mat(mat<0) = 0;

%mat(mat<70) = 0;
save([name 'filter.mat'],'mat');

%v = VideoWriter([name '.avi']);
%v.FrameRate = 3; 
%open(v);

axis tight manual 
set(gca,'nextplot','replacechildren'); 
[q,w,b] = size(mat);
for i=1:b
    maxcv = max(max(mat(:,:,16)));
    out = mat(:,:,i)/maxcv;
    imshow(out);
    i
    
 %   frame = getframe(gcf);
 %   writeVideo(v,frame);
    
  
end
%close(v);
%savecplus( [],mat,[], name );







