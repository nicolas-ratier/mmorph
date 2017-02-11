function mmshow(f, f1, f2, f3, f4, f5, f6)

    if nargin < 7, ff6 = 0; else ff6 = 1; end
    if nargin < 6, ff5 = 0; else ff5 = 1; end
    if nargin < 5, ff4 = 0; else ff4 = 1; end
    if nargin < 4, ff3 = 0; else ff3 = 1; end
    if nargin < 3, ff2 = 0; else ff2 = 1; end
    if nargin < 2, ff1 = 0; else ff1 = 1; end

    if length(size(f)) ~= 2,
       error('mmshow: can only process gray-scale and binary images.')
    end

    if     ~ff1, y = mmgshow(f);
    elseif ~ff2, y = mmgshow(f,f1);
    elseif ~ff3, y = mmgshow(f,f1,f2);
    elseif ~ff4, y = mmgshow(f,f1,f2,f3);
    elseif ~ff5, y = mmgshow(f,f1,f2,f3,f4);
    elseif ~ff6, y = mmgshow(f,f1,f2,f3,f4,f5);
    else         y = mmgshow(f,f1,f2,f3,f4,f5,f6);
    end

    if max(max(y)) <= 1,
      imshow(y)
    else
      imshow(uint8(y))
    end