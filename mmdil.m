function y = mmdil( f, b ) 

if nargin < 2,
  b = [[0,1,0],
       [1,1,1],
       [0,1,0]];
end

f = double(f);
b = double(b);

[M,N] = size(f);
[A,B] = size(b);
A = (A + 1)/2 - 1;
B = (B + 1)/2 - 1;

% Elargissement de la matrice
% BUG de imdilate d'octave ???
fe = zeros(2*A+M,2*B+N);
fe(A+1:A+M,B+1:B+N) = f;
y = imdilate(fe,b);
y = y(A+1:A+M,B+1:B+N);