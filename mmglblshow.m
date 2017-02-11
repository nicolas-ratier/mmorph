function Y =  mmglblshow(X)

    mmin = mmstats(X,'min');
    mmax = mmstats(X,'max');
    ncolors = mmax - mmin + 1;
    R = floor(rand(1,ncolors)*255);
    G = floor(rand(1,ncolors)*255);
    B = floor(rand(1,ncolors)*255);
    if mmin == 0,
       R(1) = 0;
       G(1) = 0;
       B(1) = 0;
    end
    XF = X(:) - mmin;
    r  = reshape(R(XF(:)+1),size(X));
    g  = reshape(G(XF(:)+1),size(X));
    b  = reshape(B(XF(:)+1),size(X));
    Y(:,:,1) = r;
    Y(:,:,2) = g;
    Y(:,:,3) = b;