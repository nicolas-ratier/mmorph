function Bi = mmse4linidx(f,Bc)

   [M,N] = size(f);
   [h,w] = size(Bc);
   h = (h+1)/2;
   w = (w+1)/2;
   [i,j] = find(Bc);
   Bi = (i-h) + (j-w)*M;





