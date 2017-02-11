function y = mmcloseth(f, b)

    if nargin < 2, b = mmsecross(); end
 
    y = mmsubm( mmclose(f,b), f);