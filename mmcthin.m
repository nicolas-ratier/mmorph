function y = mmcthin(f, g, Iab, n, theta, DIRECTION)

    if nargin < 6, DIRECTION = 'CLOCKWISE';  end
    if nargin < 5, theta     = 45;           end
    if nargin < 4, n         = -1;           end
    if nargin < 3, Iab       = mmhomothin(); end

    DIRECTION = upper(DIRECTION);
           
    if ~mmisbinary(f), error('f must be binary image'); end

    if n == -1, n = prod(size(f)); end
    y = f;
    old = y;
    for i = 1:n,
        for t = 0:theta:360-theta,
            sup = mmsupgen( y, mminterot(Iab, t, DIRECTION));
            y   = mmunion(mmsubm( y, sup),g);
        end
        if mmisequal(old,y), fprintf('--> mmcthin: Number of iterations=%d/%d\n',i,n); break; end
        old = y
    end
