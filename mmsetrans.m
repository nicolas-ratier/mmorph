function Bo = mmsetrans(Bi, t)

    [x,v] = mmmat2set(Bi);
    t     = repmat(t,size(x,1),1);
    Bo    = mmset2mat(x+t,v);
