function y = mmhmin(f,h,Bc)

if nargin < 3, Bc = mmsecross(); end
if nargin < 2, h  = 1;           end

g = mmaddm(f,h);
y = mmsuprec(g,f,Bc); 
