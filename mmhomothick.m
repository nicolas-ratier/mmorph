function Iab = mmhomothick()
    Iab = mmse2hmt(mmbinary([[1,1,1];
                             [0,0,0];
                             [0,0,0]]),
                   mmbinary([[0,0,0];
                             [0,1,0];
                             [1,1,1]]));
