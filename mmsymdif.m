function y = mmsymdif(f1,f2)
y = mmunion(mmsubm(f1,f2),mmsubm(f2,f1));