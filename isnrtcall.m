function FLAG = isnrtcall()
% http://octave.1599824.n4.nabble.com/who-called-me-td1633377.html

   x = dbstack();
   FLAG = 0;
   for K = 1:numel(x),
      if strcmp(x(K).name,'nrt'), FLAG = 1; end
   end

%    if (Level > 2)
%      retval = x(3).name;
%    else
%      retval = 'base';
%    end
