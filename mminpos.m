function y = mminpos(f, g, bc)

    if nargin < 3, bc = mmsecross(); end
    if ~mmisbinary(f), error('First parameter must be binary image'); end

    fg = mmgray(mmneg(f),mmdatatype(g));
    Lim = mmlimits(g); 
    k1 = Lim(2) - 1;
    y  = mmsuprec(fg, mmintersec(mmunion(g, 1), k1, fg), bc);
