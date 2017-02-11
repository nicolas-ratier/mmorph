function y = mmgradm(f, Bdil, Bero)

    if nargin < 3, Bero = mmsecross(); end
    if nargin < 2, Bdil = mmsecross(); end

    %disp('============== mmgradm ================')
    %AAA = mmdil(f,Bdil)
    %f
    %class(f)
    %Bero
    %BBB = mmero(f,Bero)

    y = mmsubm(mmdil(f,Bdil),mmero(f,Bero));