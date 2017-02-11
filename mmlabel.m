function y = mmlabel(f, Bc)

    %%%if ~isnrtcall()
    %%%if nargin < 3, Message = 1; end
    if nargin < 2, Bc = mmsecross(); end

    %%% assert mmisbinary,'Can only label binary image'

    zero = mmsubm(f,f);                 % zero image
    faux = f;
    r    = zero;
    label = 1;
    y = mmgray( f,'uint16',0);           % zero image (output)
    if ~isnrtcall(),
       fprintf('mmlabel:label=      ')
    end
    while max(max(faux >= 1e-8)),
        if ~isnrtcall(),
           %fprintf('%6d',label)
           fprintf('\b\b\b\b\b\b%06d',label);
        end
        Tmp = find(faux);
        x = Tmp(1);                     % get first unlabeled pixel
        fmark = zero;
        fmark(x) = 1;                   % get the first unlabeled pixel
        r = mminfrec( fmark, faux, Bc); % detects all pixels connected to it
        faux = mmsubm( faux, r);        % remove them from faux
        r = mmgray( r,'uint16',label);   % label them with the value label
        y = mmunion( y, r);             % merge them with the labeled image
        label = label + 1;
    end
    if ~isnrtcall(),
       fprintf('\n')
       %fprintf('mmlabel:label:END\n')
    end
