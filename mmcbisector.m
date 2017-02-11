function y = mmcbisector(f, B, n)
    y = mmintersec(f,0);
    for i = 0:n-1,
        nb  = mmsesum(B,i);
        nbp = mmsesum(B,i+1);
        f1  = mmero(f,nbp);
        f2  = mmcdil(f1,f,B,n);
        f3  = mmsubm(mmero(f,nb),f2);
        y   = mmunion(y,f3);
    end