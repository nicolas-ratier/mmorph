function y=mmopenrec(f,bero,bc)

if nargin < 3, bc   = mmsecross(); end
if nargin < 2, bero = mmsecross(); end

y = mminfrec(mmero(f,bero),f,bc); 
