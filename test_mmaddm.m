y = [

  0  0  0  0  0  0  0  0
  0  0  1  1  1  1  0  0
  0  0  1  1  1  1  1  0
  0  1  0  1  1  1  0  0
  1  1  0  0  0  0  0  0]

tmp = [

   0   0   0   0   0   0   0   0
   0   0   0   1   1   1   0   0
   0   0   1   1   1   1   1   0
   0   0   0   1   1   1   0   0
   0   0   0   0   0   0   0   0 ]

y = mmaddm(y, tmp)
