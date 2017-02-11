function y=mmsuprec(f,g,Bc)

if nargin < 3, Bc = mmsecross(); end

n = prod(size(f));
y = mmcero(f,g,Bc,n); 
