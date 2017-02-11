function y = mmdepad4se(f, Bc)

    [M,N] = size(f);            
    [h,w] = size(Bc);
    %%%assert Bh%2 and Bw%2, 'structuring element must be odd sized'
    h = (h + 1)/2 - 1;
    w = (w + 1)/2 - 1;
    
    y = f(1+h:end-h,1+w:end-w);
    