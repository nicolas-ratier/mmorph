function y = mmthreshad(f, f1, f2)

    if nargin < 3, ff2 = 0; else ff2 = 1; end
    if ~ff2, 
      y = mmbinary(f1 <= f);
    else
      y = mmbinary((f1 <= f) & (f <= f2));
    end