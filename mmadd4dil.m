function a = mmadd4dil(f, c)

    if c ~= 0,            
       y = f + c;
       Lim = mmlimits(f);
       k1  = Lim(1);
       k2  = Lim(2);
       y = ((f == k1) * k1) + ((f ~= k1) .* y);
       y = max(min(y,k2),k1);
       a = y;
    else
       a = f;
    end