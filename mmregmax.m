function y = mmregmax(f,Bc)

if nargin < 2, Bc = mmsecross(); end

y = mmregmin(mmneg(f),Bc);

%-------------------------------------------------
% CA VIENT D OU ???
%-------------------------------------------------
% if (isa(f,'uint8'))
%   k = 255;
% else
%   k = 65535;
% fminus = mmsubm(f,1);
% g = mmsubm(fplus,mminfrec(fminus,f,bc));
% y = mmunion(mmthreshad(g,1),mmthreshad(f,k)); 