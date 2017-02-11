function [clin,ccol] = csort2(lin,col,M,N)

A           = sub2ind([M,N],lin,col);
B           = csort(A,M,N);
[clin,ccol] = ind2sub([M,N],B);
