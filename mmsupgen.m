function y = mmsupgen(f, INTER)
    [A,Bc] = INTER{:};
    y = mmintersec(mmero(       f,  A ),
                   mmero( mmneg(f), Bc));
