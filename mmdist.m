function y = mmdist(f, Bc, METRIC)

    if nargin < 3, MMETRIC = 0; else MMETRIC = 1; end
    if nargin < 2, Bc = mmsecross(); end

    if MMETRIC, METRIC = upper(METRIC); end

    f = mmgray(f,'uint16');
    y = mmintersec(f,0);

    if MMETRIC == 0,
        if mmisequal(Bc, mmsecross()),
            b = int32([[-2147483647,  -1, -2147483647];
                       [         -1,   0,          -1];
                       [-2147483647,  -1, -2147483647]]);
        elseif mmisequal(Bc, mmsebox()),
            b = int32([[-1,-1,-1];
                       [-1, 0,-1];
                       [-1,-1,-1]]);
        else
            b = Bc;
        end
        while ~mmisequal(f,y),
            y = f;
            f = mmero(f,b);
        end

    elseif strcmp(METRIC,'EUCLIDEAN') || strcmp(METRIC,'EUC2'),
        b = int32(zeros(3,3));
        i = 1;
        while ~mmisequal(f,y),
            a4 = -4*i+2; 
            a2 = -2*i+1;
            b  = int32([[a4,a2,a4];
                        [a2, 0,a2];
                        [a4,a2,a4]]);
            y  = f;
            i  = i+1;
            f  = mmero(f,b);
        end
        if strcmp(METRIC,'EUCLIDEAN'),
            y = uint16(sqrt(y) + 0.5);          % A VERIFIER
        end

    end
