function y = mmwatershed(f, Bc, LINEREG)

    if nargin < 3, LINEREG = 'LINES'; end
    if nargin < 2, Bc = mmsecross();  end

    y = mmcwatershed(f,mmregmin(f,Bc),Bc,upper(LINEREG));
