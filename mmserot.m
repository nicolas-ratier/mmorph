function BROT = mmserot(B, theta, DIRECTION)

   if nargin < 3, DIRECTION = 'CLOCKWISE'; end
   if nargin < 2, theta     = 45;          end

    DIRECTION = upper(DIRECTION);            
    if strcmp(DIRECTION,'ANTI-CLOCKWISE'),
       theta = -theta;
    end
    theta = pi * theta/180;
    [y,v] = mmmat2set(B);

    %%% if len(y)==0: return mmbinary([0])                 TODO

    x0 = y(:,2)*cos(theta) - y(:,1)*sin(theta);
    x1 = y(:,2)*sin(theta) + y(:,1)*cos(theta);
    x0 = fix((x0 +0.5).*(x0>=0) + (x0-0.5).*(x0<0));        % TODO
    x1 = fix((x1 +0.5).*(x1>=0) + (x1-0.5).*(x1<0));        % TODO
    x = transpose([transpose(x1);transpose(x0)]);
    BROT = mmset2mat(x,v);
