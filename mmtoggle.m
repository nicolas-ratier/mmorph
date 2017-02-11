function y = mmtoggle(f, f1, f2, OPTION)

if nargin < 4, OPTION = 'GRAY'; end

y = mmbinary(mmsubm(f,f1),mmsubm(f2,f));
if strcmp(upper(OPTION),'GRAY'),
   t = mmgray(y);
   y = mmunion(mmintersec(mmneg(t),f1),mmintersec(t,f2));
end
