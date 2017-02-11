function Iab = mmhomothin()
    Iab = mmse2hmt(mmbinary([[0,0,0];
                             [0,1,0];
                             [1,1,1]]),
                   mmbinary([[1,1,1];
                             [0,0,0];
                             [0,0,0]]));
