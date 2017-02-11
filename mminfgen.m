function y = mminfgen(f, Iab)
    [A,Bc] = Iab{:};
    y = mmunion(mmdil( f, A),mmdil( mmneg(f), Bc));
