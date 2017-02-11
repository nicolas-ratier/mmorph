function B = mmsecross(r)

    if nargin == 0, r = 1; end

    B = mmsesum(mmbinary([[0,1,0];
                          [1,1,1];
                          [0,1,0]]),r);