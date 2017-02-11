function y = mmcloserec(f,bdil,bc)

if nargin < 3, bc   = mmsecross(); end
if nargin < 2, bdil = mmsecross(); end

y = mmsuprec(mmdil(f,bdil),f,bc); 
