function y=mmcenter(f,b)

if nargin < 2, b = mmsecross(); end

y = f;
diff = 0;
while (diff ~= 1)
   aux = y;
   beta1 = mmasf(y,'COC',b,1);
   beta2 = mmasf(y,'OCO',b,1);
   y = mmunion(mmintersec(y,beta1),beta2);
   diff = mmisequal(aux,y);
end; 
