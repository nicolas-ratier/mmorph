f  = [11 12 13 14 15 16,
      21 22 23 24 25 26,
      31 32 33 34 35 36,
      41 42 43 44 45 46,
      51 52 53 54 55 56]
   
se = [0 1 0; 1 1 1 ; 0 1 0]
g = mmpad4se(f,se,0);
mmdepad4se(g,se)

se = [0 0 0 0 0; 1 0 1 1 1; 0 0 0 0 0]
g = mmpad4se(f,se,-inf)
mmdepad4se(g,se)