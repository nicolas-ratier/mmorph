function y = mmcloserecth(f, bdil, bc)

    if nargin < 3, bc   = mmsecross(); end
    if nargin < 2, bdil = mmsecross(); end

    y = mmsubm(mmcloserec(f,bdil,bc), f);
