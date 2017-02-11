function y = mmgdist(f, g, Bc, METRIC)

    if nargin < 4, MMETRIC = 0; else MMETRIC = 1; end
    if nargin < 3, Bc = mmsecross(); end

    %if ~MMETRIC, error('Does not support EUCLIDEAN'); end     TODO

    fneg = mmneg(f);
    gneg = mmneg(g);
    y    = mmgray(gneg,'uint16',1);
    ero  = mmintersec(y,0);
    aux  = y;
    i = 1;
    while ~mmisequal(ero,aux),
        aux = ero;
        ero = mmcero(gneg,fneg,Bc,i);
        y = mmaddm(y,mmgray(ero,'uint16',1));
        i = i + 1;
    end
    y = mmunion(y,mmgray(ero,'uint16'));
