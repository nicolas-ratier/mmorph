function y = mmskiz(f, Bc, LINEREG, METRIC=None)

    if nargin < 4, MMETRIC = 0; else MMETRIC = 1; end
    if nargin < 3, LINEREG = 'LINES'; end
    if nargin < 2, Bc = mmsecross();  end

    LINEREG = upper(LINEREG);
    if MMETRIC, METRIC = upper(METRIC); end

    d = mmdist( mmneg(f), Bc, METRIC);
    y = mmcwatershed(d,f,Bc,LINEREG);
