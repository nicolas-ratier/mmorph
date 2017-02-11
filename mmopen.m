function y = mmopen(f,b)

if nargin < 2, b = mmsecross(); end

y = mmdil(mmero(f,b),b); 
