function y = mmseshow(B, option)

    if nargin < 2, option = 'NORMAL'; end

    option = upper(option);
      
    if strcmp(option,'NON-FLAT'),
        y = int32([0])
        if mmisbinary(B),
            B = mmintersec(mmgray(B,'int32'),0);
        end
        y = mmsedil(y,B);

    elseif strcmp(option,'NORMAL'),
        if mmisbinary(B),
           y = mmbinary([1]);
        else
           y = int32([0]);
        end
        y = mmsedil(y,B);

    elseif strcmp(option,'EXPAND'),
        assert(logical(mmisbinary(B)),'This option is only available with flat SE');
        y  = mmsedil(mmbinary([1]),B);
        b1 = mmbinary(y>=0);
        b0 = mmero(y,B);
        y  = mmbshow(b1,y,b0);

    else
        error('mmseshow: not a valid flag: NORMAL, EXPAND or NON-FLAT')
    end

