gg = zeros(max(vyt),1);
nums= zeros(max(vyt),1);
for i = 1:length(vyt)
    k = vyt(i);
    nums(k) = nums(k)+1;
    gg(k) = gg(k)+vel2(i);
end
gg = gg./nums;
plot(gg);