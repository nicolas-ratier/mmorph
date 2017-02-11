function y = mmbinary( f, k1 )

if nargin < 2, k1 = 1; end
y = f >= k1;