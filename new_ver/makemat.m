function makemat(dirf)
    am = dir(dirf);
    for i = 3:length(am)
        disp(['Name of file = ', am(i).name]);
        makemat_([dirf '/' am(i).name '/'],am(i).name)
    end
end


function makemat_(dirf,name)
fn = dir([dirf '*.tif']);
for i=1: length(fn)
    filename(i,:) = [dirf  fn(i).name];
end
a = single(imread(filename(i,:)));
[q,w] = size(a);
mp = length(fn);
alls=zeros(q,w,mp,'single');

for i = 1:length(fn);
    alls(:,:,i) =single( imread(filename(i,:)));
end
save([name 'orig.mat'],'alls');
end