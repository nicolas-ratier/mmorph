function y = mmunion(f1, f2, f3, f4, f5)

y = max(f1,f2);
if nargin >= 3, y = max(y,f3); end
if nargin >= 4, y = max(y,f4); end
if nargin >= 5, y = max(y,f5); end
