function y = mmskelm(f, B, option)

    if nargin < 3, option = 'binary';    end
    if nargin < 2, B      = mmsecross(); end

    %%% assert mmisbinary(f),'Input binary image only'    TODO

    option = upper(option);
    Lim    = mmlimits(f);
    k1     = Lim(1);
    k2     = Lim(2);
    y = mmgray(mmintersec(f, k1),'uint16');
    iszero = y;
    nb = mmsesum(B,0);
    for r = 1:65534,
        ero = mmero( f, nb);
        if mmisequal(ero, iszero), break; end
        f1 = mmopenth( ero, B);
        nb = mmsedil(nb, B);
        y  = mmunion(y, mmgray(f1,'uint16',r));
    end
    if strcmp(option,'BINARY'),
        y = mmbinary(y);
    end