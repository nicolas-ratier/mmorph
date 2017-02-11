function y = mmopenth(f, b)

    if nargin < 2, b = mmsecross(); end

    y = mmsubm(f, mmopen(f,b));