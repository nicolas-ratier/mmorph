
fmark = [
   0   0   0   0   0
   1   0   0   0   0 ];

faux = [
   0   1   0   1   1
   1   0   0   1   0 ];

Bc = [
   0   1   0
   1   1   1
   0   1   0 ];

n = 10;

%%% mminfrec( fmark, faux, Bc)
mmcdil(fmark,faux,Bc,n);



y = [
   0   0   0   0   0
   1   0   0   0   0 ]

b = [
   0   1   0
   1   1   1
   0   1   0 ]

mmdil(y,b)