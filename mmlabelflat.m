function y = mmlabelflat(f, Bc)

    %%% _lambda not implemented
    if nargin < 2, Bc = mmsecross(); end

    zero = mmbinary(mmsubm(f,f));         % zero image
    faux = mmneg(zero);
    r = zero;
    label = 1;
    y = mmgray( zero,'uint16',0);          % zero image (output)
    if ~isnrtcall(),
       fprintf('mmlabelflat:label=   ')
    end
    while max(max(faux >= 1e-8)),
        if ~isnrtcall(),
           %fprintf('%d,',label)
           fprintf('\b\b\b%03d',label);
        end
        Tmp = find(faux);
        x = Tmp(1);                       % get first unlabeled pixel
        fmark = zero;
        fmark(x) = 1;                     % get the first unlabeled pixel
        f2aux = mmcmp( f, '==', f(x));
        r = mminfrec( fmark, f2aux, Bc);  % detects all pixels connected to it
        faux = mmsubm( faux, r);          % remove them from faux
        r = mmgray( r,'uint16',label);     % label them with the value label
        y = mmunion( y, r);               % merge them with the labeled image
        label = label + 1;
    end
    if ~isnrtcall(),
       fprintf('\n')
    end
