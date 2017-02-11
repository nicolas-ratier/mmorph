function Y = mmgshow(X, X1, X2, X3, X4, X5, X6)

    if nargin < 7, XX6 = 0; else XX6 = 1; end
    if nargin < 6, XX5 = 0; else XX5 = 1; end
    if nargin < 5, XX4 = 0; else XX4 = 1; end
    if nargin < 4, XX3 = 0; else XX3 = 1; end
    if nargin < 3, XX2 = 0; else XX2 = 1; end
    if nargin < 2, XX1 = 0; else XX1 = 1; end

    if mmisbinary(X), X = mmgray(X,'uint8'); end
    r = X;
    g = X;
    b = X;

    if XX1, % red 1 0 0
      if ~mmisbinary(X1), error('X1 must be binary overlay'); end
      x1 = mmgray(X1,'uint8');
      r = mmunion(r,x1);
      g = mmintersec(g,mmneg(uint8(x1)));
      b = mmintersec(b,mmneg(uint8(x1)));
    end

    if XX2, % green 0 1 0
      if ~mmisbinary(X2), error('X2 must be binary overlay'); end
      x2 = mmgray(X2,'uint8');
      r = mmintersec(r,mmneg(uint8(x2)));
      g = mmunion(g,x2);
      b = mmintersec(b,mmneg(uint8(x2)));
    end

    if XX3, % blue 0 0 1
      if ~mmisbinary(X3), error('X3 must be binary overlay'); end
      x3 = mmgray(X3,'uint8');
      r = mmintersec(r,mmneg(uint8(x3)));
      g = mmintersec(g,mmneg(uint8(x3)));
      b = mmunion(b,x3);
    end

    if XX4, % magenta 1 0 1
      if ~mmisbinary(X4), error('X4 must be binary overlay'); end
      x4 = mmgray(X4,'uint8');
      r = mmunion(r,x4);
      g = mmintersec(g,mmneg(uint8(x4)));
      b = mmunion(b,x4);
    end

    if XX5, % yellow 1 1 0
      if ~mmisbinary(X5), error('X5 must be binary overlay'); end
      x5 = mmgray(X5,'uint8');
      r = mmunion(r,x5);
      g = mmunion(g,x5);
      b = mmintersec(b,mmneg(uint8(x5)));
    end

    if XX6, % cyan 0 1 1
      if ~mmisbinary(X6), error('X6 must be binary overlay'); end
      x6 = mmgray(X6,'uint8');
      r = mmintersec(r,mmneg(uint8(x6)));
      g = mmunion(g,x6);
      b = mmunion(b,x6);
    end

    Y(:,:,1) = r;
    Y(:,:,2) = g;
    Y(:,:,3) = b;
