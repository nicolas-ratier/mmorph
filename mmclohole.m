function y = mmclohole(f,Bc)

if nargin < 2, Bc = mmsecross(); end

delta_f = mmframe(f);
y       = mmneg(mminfrec(delta_f,mmneg(f),Bc)); 
