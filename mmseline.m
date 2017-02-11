function B = mmseline(l, theta)

    if nargin < 2, theta = 0; end
    if nargin < 1, l     = 3; end

    theta = pi*theta/180;

    if abs(tan(theta)) <= 1,
        s  = sign(cos(theta));
        x0 = [0 : s : l*cos(theta) - (s*0.5)];
        x1 = floor(x0 * tan(theta) + 0.5);
    else,
        s  = sign(sin(theta));
        x1 = [0 : s : l*sin(theta) - (s*0.5)];
        x0 = floor(x1 / tan(theta) + 0.5);
    end
    x = transpose([x1;x0]);
    %%%B = mmset2mat((x,mmbinary(ones((x.shape[1],1)))))   % 2ieme argument par defaut
    B = mmset2mat(x);