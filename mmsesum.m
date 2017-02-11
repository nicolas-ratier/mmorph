function NB = mmsesum(B,N) 

if nargin < 2, N = 1;           end
if nargin < 1, B = mmsecross(); end

if N == 0,
   if mmisbinary(B), NB = mmbinary([1]); return;
   else              NB = ([0]);         return; % identity
   end
end

NB = B;
for i = 1:N-1,
   NB = mmsedil(NB,B);
end
