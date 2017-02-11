function y = mmareaclose(f,a,Bc)

if nargin < 3, Bc = mmsecross(); end

y = mmneg(mmareaopen(mmneg(f),a,Bc));
