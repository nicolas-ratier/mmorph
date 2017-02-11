function y = mmbshow(f1,f2,f3,factor)

        if nargin < 4, factor = 17; end
        if nargin < 3, ff3    = 0;  else ff3 = 1; end
        if nargin < 2, ff2    = 0;  else ff2 = 1; end

        %%% if f1.shape == ()    : f1 = array([f1])           TODO
        %%% if len(f1.shape) == 1: f1 = f1[NewAxis,:]         TODO

        %if (size(f1) ~= size(f2) | (size(f1) ~= size(f3) | (size(f2) ~= size(f3),
        %   error('Different sizes.');
        %end

        s = factor;
        if factor < 9, s = 9; end

        [h,w] = size(f1);
        y     = zeros(s*h,s*w);

        % Circle
        xc = repmat(1:s,s,1);
        yc = transpose(xc);
        r  = floor((s-8)/2. + 0.5);      % r = (s-8+1)/2   Mieux !!!
        circle = (xc - floor(s/2) - 1).^2 + (yc - floor(s/2) - 1).^2 <= r^2;

        % Filled Rectangle
        fillrect = zeros(s,s);
        fillrect(1:2:s,1:2:s) = 1;
        fillrect(2:2:s,2:2:s) = 1;
        fillrect = 1 - fillrect;      %%% (Damier inversé)
        fillrect(1,:) = 0;
        fillrect(s,:) = 0;
        fillrect(:,1) = 0;
        fillrect(:,s) = 0;

        % Figure
        for i = 1:h;
            for j = 1:w,
                m = s*(i-1) + 1;
                n = s*(j-1) + 1;
                if f1(i,j) ~= 0,
                    y(m      ,n:n+s-1) = 1;
                    y(m+s-1  ,n:n+s-1) = 1;
                    y(m:m+s-1,n    )   = 1;
                    y(m:m+s-1,n+s-1)   = 1;
                end
                if ff2 == 1, 
                  if f2(i,j) ~= 0,
                      y(m:m+s-1, n:n+s-1) = y(m:m+s-1, n:n+s-1) + circle;
                  end
                end
                if ff3 == 1,
                   if f3(i,j) ~= 0,
                      y(m:m+s-1, n:n+s-1) = y(m:m+s-1, n:n+s-1) + fillrect;
                   end
                end
            end
        end
        y = y > 0;
