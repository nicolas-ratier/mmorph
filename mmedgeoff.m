function y = mmedgeoff(f, Bc)

    if nargin < 2, Bc = mmsecross(); end

    edge = mmframe(f);
    y = mmsubm( f, mminfrec(edge, f, Bc));