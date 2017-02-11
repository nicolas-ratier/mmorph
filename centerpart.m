function y = centerpart(f)

[M,N] = size(f);
M = M - mod(M,3);
N = N - mod(N,3);
M = M/3;
N = N/3;
y = f(M+1:2*M,N+1:2*N); 