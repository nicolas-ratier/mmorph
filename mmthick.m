function y = mmthick(f, Iab, n, theta, DIRECTION)

    if nargin < 5, DIRECTION = 'CLOCKWISE';   end
    if nargin < 4, theta     = 45;            end
    if nargin < 3, n         = -1;            end
    if nargin < 2, Iab       = mmhomothick(); end

    DIRECTION = upper(DIRECTION);
            
    if ~mmisbinary(f), error('f must be binary image'); end

    if n == -1, n = prod(size(f)); end
    y = f;
    zero = mmintersec(f,0);
    for i = 1:n,
        aux = zero;
        for t = 0:theta:360-theta,
            sup = mmsupgen( y, mminterot(Iab, t, DIRECTION));
            aux = mmunion( aux, sup);
            y   = mmunion( y, sup);
        end
        if mmisequal(aux,zero), fprintf('--> mmthick: Number of iterations=%d/%d\n',i,n); break; end
    end
