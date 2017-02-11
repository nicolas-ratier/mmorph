function [c,h] = mmhistogram( f )

% test si image = uint8 ou binary
%Lim = mmlimits(f);
f   = double(f);
Lim = [0,max(max(f))];
c   = 0:Lim(2);

h = zeros(1,Lim(2)+1);
[M,N] = size(f);
for i = 1:M,
   for j = 1:N,
      h(f(i,j)+1) = h(f(i,j)+1) + 1;
   end
end
%%% [counts, x] = imhist(f);