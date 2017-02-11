function y = mmdrawv(f, data, value, GEOM)

    GEOM = upper(GEOM);
    y    = f;

    [M,N] = size(f);
    lin   = data(:,1);
    col   = data(:,2);
    K     = length(lin);

%    if len(f.shape) == 1: f = f[NewAxis,:]                     TODO
    if isscalar(value), 
       value = value + zeros(1,K);
    end

    if length(lin) ~= length(value),
        error('Number of points must match n. of colors.')
    end

    if strcmp(GEOM,'POINT'),
        i    = (col-1)*M + lin;
        y(i) = value;

    elseif strcmp(GEOM,'LINE'),
        for k = 1:K-1,
            delta = double(lin(k+1) - lin(k))/double(col(k+1) - col(k) + 1e-10);
            if abs(delta) <= 1,
                if col(k) < col(k+1), x_ = col(k  ):col(k+1);
                else                  x_ = col(k+1):col(k  );
                end
                y_ = round(delta*double(x_-col(k)) + double(lin(k)));
            else
                if lin(k) < lin(k+1), y_ = lin(k  ):lin(k+1);
                else                  y_ = lin(k+1):lin(k  );
                end
                x_ = round(double(y_-lin(k))/delta + double(col(k)));
            end
            i_    = (x_-1)*M + y_;
            y(i_) = value(k);
        end

    elseif strcmp(GEOM,'RECT'),
        for k = 1:K,
            x0 = data(k,1);
            y0 = data(k,2);
            x1 = data(k,3);
            y1 = data(k,4);
            y(x0:x1,y0)     = value(k);
            y(x0:x1,y1)     = value(k);
            y(x0,y0+1:y1-1) = value(k);
            y(x1,y0+1:y1-1) = value(k);
        end

    elseif strcmp(GEOM,'FILLEDRECT'),
        for k = 1:K,
            x0 = data(k,1);
            y0 = data(k,2);
            x1 = data(k,3);
            y1 = data(k,4);
            y(x0:x1,y0:y1) = value(k);
        end

    else
        error('GEOM should be ''POINT'', ''LINE'', ''RECT'', or ''FILLEDRECT''.')
    end