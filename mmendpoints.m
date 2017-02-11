function Iab = mmendpoints(OPTION)

    if nargin == 0, OPTION = 'LOOP'; end

    OPTION = upper(OPTION);
    if strcmp(OPTION,'LOOP'),
        Iab = mmse2hmt(mmbinary([[0,0,0];
                                 [0,1,0];
                                 [0,0,0]]),
                       mmbinary([[0,0,0];
                                 [1,0,1];
                                 [1,1,1]]));

    elseif strcmp(OPTION,'HOMOTOPIC'),
        Iab = mmse2hmt(mmbinary([[0,1,0];
                                 [0,1,0];
                                 [0,0,0]]),
                       mmbinary([[0,0,0];
                                 [1,0,1];
                                 [1,1,1]]));
    end