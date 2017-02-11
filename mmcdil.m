function y = mmcdil(f,g,b,n)

if nargin < 4, n = 1;           end
if nargin < 3, b = mmsecross(); end

  y = mmintersec(f,g);
  for i = 1:n,
    aux = y;
    y = mmintersec(mmdil(y,b),g);
    if mmisequal(y,aux), break; end
  end
