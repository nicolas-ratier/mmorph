function s = int2bank(n)
% Return a string of an integer in bank format
%  >> int2bank(12345)
%  ans = 12,345


assert(floor(n) == n,'int2bank: n must be integer')

s   = sprintf('%ld',n);
FIN = length(s);
for k = FIN-2:-3:2,
   s(k+1:end+1) = s(k:end);
   s(k)         = ',';
end
