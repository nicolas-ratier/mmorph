function y = mmintersec(f1, f2, f3, f4, f5)

y = min(f1,f2);
if nargin >= 3, y = min(y,f3); end
if nargin >= 4, y = min(y,f4); end
if nargin >= 5, y = min(y,f5); end
