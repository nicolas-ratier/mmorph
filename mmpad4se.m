function y = mmpad4se(f, Bc, value)

    if nargin < 3, value = 0; end

    [M,N] = size(f);            
    [h,w] = size(Bc);
    %%%assert Bh%2 and Bw%2, 'structuring element must be odd sized'
    h = (h + 1)/2 - 1;
    w = (w + 1)/2 - 1;
    
    y = f;
    y = [value*ones(M,    w), y, value*ones(M,    w)];
    y = [value*ones(h,N+2*w); y; value*ones(h,N+2*w)];
 