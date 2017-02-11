function y = mmopenrecth(f, bero, bc)

    if nargin < 3, bc = mmsecross();   end
    if nargin < 2, bero = mmsecross(); end
 
    y = mmsubm(f, mmopenrec( f, bero, bc));
