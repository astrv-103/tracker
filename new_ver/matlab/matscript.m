clear all
dirf = '/home/arshat/data/commets_all/HT1080big/HT1080';
am = dir([dirf '/*tif']);
for i = 1:length(am)
    
    fname = [dirf '/' am(i).name];
    info = imfinfo(fname);
    num_images = numel(info);
    
    kl = max([info(1).Width,info(1).Height]);
    alls = zeros(kl,kl,num_images);
    
    
    for k = 1:num_images
        A = imread(fname, k);
        [q,w] = size(A);
        alls(1:q,1:w,k) = A;
    end
    save([am(i).name(1:length(am(i).name)-4) 'orig.mat'],'alls');
end
