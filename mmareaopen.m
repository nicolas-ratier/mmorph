function y = mmareaopen(f,a,Bc)

    if nargin < 3, Bc = mmsecross(); end
    if mmisbinary(f),
      fr = mmlabel(f,Bc);      % binary area open, use area measurement
      g = mmblob(fr,'area');
      y = mmthreshad(g,a);
    else
      y = mmintersec(f,0);
      zero = mmbinary(y);
      k1 = mmstats(f,'min');
      k2 = mmstats(f,'max');
      for k = k1:k2,           % gray-scale, use thresholding decomposition
        fk = mmthreshad(f,k);
        fo = mmareaopen(fk,a,Bc);
        if mmisequal(fo,zero),
          break
        end
        y = mmunion(y, mmgray(fo,mmdatatype(f),k));
      end
    end
