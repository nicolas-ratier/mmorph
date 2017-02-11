function y = mmneg(f) 

   Lim = mmlimits(f);
   y   = Lim(1) + Lim(2) - f;

%%% y = imcomplement(f);