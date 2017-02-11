function h = mmpatspec(f, type, n, Bc, Buser)

    if nargin < 5, Buser = mmsecross(); end
    if nargin < 4, Bc    = mmsecross(); end
    if nargin < 3, n     = 65535;       end
    if nargin < 2, type  = 'OCTAGON';   end

    %%% assert mmisbinary(f),'Error: input image is not binary'    TODO

    g=mmopentransf(f,type,n,Bc,Buser);
    [n,h] = mmhistogram(g);
    h(1)  = [];
