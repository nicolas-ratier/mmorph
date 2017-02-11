function [ks,kp] = csort(k,M,N)

  % Ajouter le test des parametres d'entree
  % k doit etre entre 1 et M*N
  % k peut etre un vecteur

  m = rem (k-1,M) + 1;
  n = ceil(k/M);
  mp = m -1;
  np = n -1;
  kp = np + mp*N;
  kp = sort(kp);
  mp = ceil((kp+1)/N) - 1;
  np = rem (kp,N);
  m  = mp + 1;
  n  = np + 1;
  ks = m + (n-1)*M;
