function Y = mmconcat(DIM, X1, X2, X3, X4)

    [h1,w1] = size(X1);
    [h2,w2] = size(X2);

    h3 = 0; w3 = 0;
    h4 = 0; w4 = 0;
    if nargin >= 4, [h3,w3] = size(X3); end
    if nargin >= 5, [h4,w4] = size(X4); end

    h = [h1, h2, h3, h4];
    w = [w1, w2, w3, w4];

    if ismember(DIM,{'HEIGHT', 'H', 'h', 'height'}),
       hy = sum(h); 
       wy = max(w);
       Y = zeros(hy,wy);
       Y(   1:h1   , 1:w1) = X1;
       Y(h1+1:h1+h2, 1:w2) = X2;
       if nargin >= 4, Y(h1+h2+1:h1+h2+h3, 1:w3) = X3; end
       if nargin >= 5, Y(h1+h2+h3+1:end,   1:w4) = X4; end
       
    elseif ismember(DIM,{'WIDTH', 'W', 'w', 'width'}),
       hy = max(h); 
       wy = sum(w);
       Y = zeros(hy,wy);
       Y(1:h1,    1:w1   ) = X1;
       Y(1:h2, w1+1:w1+w2) = X2;
       if nargin >= 4, Y(1:h3, w1+w2+1:w1+w2+w3) = X3; end
       if nargin >= 5, Y(1:h4, w1+w2+w3+1:end)   = X4; end

    else
       error('Second arg must be ''WIDTH'' or ''HEIGHT'', Here DIM = ''%s''',DIM);
    end
