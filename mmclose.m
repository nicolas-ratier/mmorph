function y = mmclose(f,b)

if nargin < 2, b = mmsecross(); end
y = mmero(mmdil(f,b),b);