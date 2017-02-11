function y = mminfrec(f,g,bc)

if nargin < 3, bc = mmsecross(); end

n = prod(size(f));
y = mmcdil(f,g,bc,n);
