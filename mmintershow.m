function s = mmintershow(Iab)

    %assert (type(Iab) is tuple) and (len(Iab) == 2),       TODO
    %'not proper fortmat of hit-or-miss template'

    [A,Bc] = Iab{:};
    S = mmseunion(A,Bc);
    Z = mmintersec(S,0);
    P = S + mmseunion(Z,A);

    % TODO Faire une version vectorielle
    [M,N] = size(P);
    for m = 1:M,
       for n = 1:N,
          if     P(m,n) == 0, fprintf('. ');
          elseif P(m,n) == 1, fprintf('0 ');
          elseif P(m,n) == 2, fprintf('1 ');
          end
       end
       fprintf('\n')
    end

    %n = prod(size(S));
    %one  = reshape(array(n*'1','c'),S.shape)
    %zero = reshape(array(n*'0','c'),S.shape)
    %x    = reshape(array(n*'.','c'),S.shape)
    %saux = choose( S + mmseunion(Z,A), ( x, zero, one))
    %s = ''
    %for i in range(saux.shape[0]):
    %    s=s+(join(list(saux[i]))+' \n')
    %return s