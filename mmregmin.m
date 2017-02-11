function y = mmregmin(f,Bc)

if nargin < 2, Bc = mmsecross(); end

fplus = mmaddm(f,1);
g     = mmsubm(mmsuprec(fplus,f,Bc),f);
y     = mmunion(mmthreshad(g,1),mmthreshad(f,0,0)); 
