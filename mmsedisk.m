function B = mmsedisk(r, METRIC, FLAT, h)

    if nargin < 4, h      = 0;           end
    if nargin < 3, FLAT   = 'FLAT';      end
    if nargin < 2, METRIC = 'EUCLIDEAN'; end
    if nargin < 1, r      = 3;           end

    METRIC = upper(METRIC);
    FLAT   = upper(FLAT);           
    %%% assert DIM=='2D','Supports only 2D structuring elements'

    if strcmp(FLAT,'FLAT'), 
       y = mmbinary([1]);
    else
       error('non flat se')
       %%% y = int32([h])
    end
    if r==0, B = y; return; end

    if strcmp(METRIC,'CITY-BLOCK'),
        if strcmp(FLAT,'FLAT'),
            b = mmsecross(1);
        else
            error('non flat se')
            %b = int32([[-2147483647, 0,-2147483647],
            %           [          0, 1,          0],
            %           [-2147483647, 0,-2147483647]])
        end
        B = mmsedil(y,mmsesum(b,r));

    elseif strcmp(METRIC,'CHESSBOARD'),
        if strcmp(FLAT,'FLAT'),
            b = mmsebox(1);
        else
            error('non flat se')
            %b = int32([[1,1,1],
            %           [1,1,1],
            %           [1,1,1]])
        end
        B = mmsedil(y,mmsesum(b,r));

    elseif strcmp(METRIC,'OCTAGON'),
        if strcmp(FLAT,'FLAT'),
            b1 = mmsebox(1);
            b2 = mmsecross(1);
        else
            error('non flat se')
            %b1 = int32([[1,1,1],[1,1,1],[1,1,1]])
            %b2 = int32([[-2147483647, 0,-2147483647],
            %            [          0, 1,          0],
            %            [-2147483647, 0,-2147483647]])
        end
        if r == 1,
           B = b1;
        else
           B = mmsedil( mmsedil(y,mmsesum(b1,r/2)) ,mmsesum(b2,(r+1)/2));
        end

    elseif strcmp(METRIC,'EUCLIDEAN'),
        v  = [-r:r];
        x  = repmat(v,size(v,2),1);
        y  = transpose(x);
        Be = mmbinary(sqrt(x.*x + y.*y) <= (r+0.5));
        if strcmp(FLAT,'FLAT'),
            B = Be;
        else
            error('non flat se')
            %be = h + int32( sqrt( maximum((r+0.5)*(r+0.5) - (x*x) - (y*y),0)))
            %be = mmintersec(mmgray(Be,'int32'),be)
            %B  = be
        end
    else
        error('Non valid metric')
    end
