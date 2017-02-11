function y=mmasfrec(f,SEQ,b,bc,n)

if nargin < 5, n   = 1;           end
if nargin < 4, bc  = mmsecross(); end
if nargin < 3, b   = mmsecross(); end
if nargin < 2, SEQ = 'OC';        end

SEQ = upper(SEQ);

switch SEQ
case 'OC',
   y = f;
   for i=1:n
      nb = mmsesum(b,i);
      y = mmcloserec(y,nb,bc);
      y = mmopenrec(y,nb,bc);
   end;
case 'CO',
   y = f;
   for i=1:n
      nb = mmsesum(b,i);
      y = mmopenrec(y,nb,bc);
      y = mmcloserec(y,nb,bc);
   end;
otherwise
   error('Only accepts OC or CO for SEQ parameter')
end;
