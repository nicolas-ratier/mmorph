function B = mmsebox(r)

    if nargin == 0, r = 1; end

    B = mmsesum(mmbinary([[1,1,1];
                          [1,1,1];
                          [1,1,1]]),r);