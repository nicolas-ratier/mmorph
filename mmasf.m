function y = mmasf(f,SEQ,b,n)

if nargin < 4, n   = 1;           end
if nargin < 3, b   = mmsecross(); end
if nargin < 2, SEQ = 'OC';        end

SEQ=upper(SEQ);

switch SEQ
case 'OC',
   y = f;
   for i=1:n
      nb = mmsesum(b,i);
      y = mmclose(y,nb);
      y = mmopen(y,nb);
   end;
case 'CO',
   y = f;
   for i=1:n
      nb = mmsesum(b,i);
      y = mmopen(y,nb);
      y = mmclose(y,nb);
   end;
case 'OCO',
   y = f;
   for i=1:n
      nb = mmsesum(b,i);
      y = mmopen(y,nb);
      y = mmclose(y,nb);
      y = mmopen(y,nb);
   end;   
case 'COC',
   y = f;
   for i=1:n
      nb = mmsesum(b,i);
      y = mmclose(y,nb);
      y = mmopen(y,nb);
      y = mmclose(y,nb);
   end;
end;