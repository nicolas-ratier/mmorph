function y = mmthin(f, Iab, n, theta, DIRECTION)

    if nargin < 5, DIRECTION = 'CLOCKWISE';  end
    if nargin < 4, theta     = 45;           end
    if nargin < 3, n         = -1;           end
    if nargin < 2, Iab       = mmhomothin(); end

    DIRECTION = upper(DIRECTION);
            
    if ~mmisbinary(f), error('f must be binary image'); end

    if n == -1, n = prod(size(f)); end
    y = f;
    zero = mmintersec(f,0);
    fprintf('mmthin:i=      ')
    for i =1:n,
        fprintf('\b\b\b\b\b\b%06d',i);
        aux = zero;
        for t = 0:theta:360-theta,
            sup = mmsupgen( y, mminterot(Iab, t, DIRECTION));
            aux = mmunion( aux, sup);
            y = mmsubm( y, sup);
        end
        if mmisequal(aux,zero), break; end
    end
    fprintf('\n')
