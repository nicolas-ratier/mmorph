function y = mmopentransf(f, type, n, Bc, Buser)

    if nargin < 5, Buser = mmsecross(); end
    if nargin < 4, Bc    = mmsecross(); end
    if nargin < 3, n     = 65535;       end
    if nargin < 2, type  = 'OCTAGON';   end

    %%% assert mmisbinary(f),'Error: input image is not binary'

    type = upper(type);
    rec_flag = strcmp(type(end-3:end),'-REC');

    if rec_flag == 1,
        type = type(1:end-4); % remove the -rec suffix
    end

    flag = ~ ((strcmp(type,'OCTAGON'))    |
              (strcmp(type,'CHESSBOARD')) |
              (strcmp(type,'CITY-BLOCK')));

    if ~flag,
        n  = min(n,min(size(f)));
    elseif  strcmp(type,'LINEAR-H'),
        se = mmbinary([1, 1, 1]);
        n  = min(n,size(f,2));
    elseif  strcmp(type,'LINEAR-V'),
        se = mmbinary([[1];[1];[1]]);
        n  = min(n,size(f,1));
    elseif  strcmp(type,'LINEAR-45R'),
        se = mmbinary([[0, 0, 1];[0, 1, 0];[1, 0, 0]]);
        n  = min(n,min(size(f)));
    elseif  strcmp(type,'LINEAR-45L'),
        se = mmbinary([[1, 0, 0];[0, 1, 0];[0, 0, 1]]);
        n  = min(n,min(size(f)));
    elseif  strcmp(type,'USER'),
        se = Buser;
        n  = min(n,min(size(f)));
    else
        error('Only accepts OCTAGON, CHESSBOARD, CITY-BLOCK, LINEAR-H, LINEAR-V, LINEAR-45R, LINEAR-45L, or USER as type, or with suffix -REC.')
    end

    k = 0;
    y = uint8(zeros(size(f)));
    a = mmbinary([1]);
    z = mmbinary([0]);

    if ~isnrtcall(),
       fprintf('mmopentransf:k=   ');
    end
    while ~ (mmisequal(a,z) | (k>=n)),
        if ~isnrtcall(),
            %fprintf('processing r=%d\n',k);
            fprintf('\b\b\b%03d',k);
        end
        if flag,
            a = mmopen(f,mmsesum(se,k));
        else
            a = mmopen(f,mmsedisk(k,type));
        end
        y = mmaddm(y, mmgray(a,'uint8',1));
        k = k+1;
    end
    if ~isnrtcall(),
       fprintf('\n');
    end

    if rec_flag == 1,
        y = mmgrain(mmlabel(f,Bc),y,'max');
    end
