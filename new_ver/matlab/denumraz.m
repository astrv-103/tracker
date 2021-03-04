function b = denumraz( num )

  
  
    ii=1;
    b(ii)=rem(num,10);
    while (fix(num / 10) > 0.0)
        ii = ii + 1;
         num = fix(num / 10);
         b(ii) = rem(num,10);
    end
  
end