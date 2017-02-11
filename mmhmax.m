function y = mmhmax(f,h,Bc)

if nargin < 3, Bc = mmsecross(); end
if nargin < 2, h  = 1;           end

g = mmsubm(f,h);
y = mminfrec(g,f,Bc); 
