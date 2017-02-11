function y = mmlimits(f)

    code = class(f);
    if     strcmp(code,'logical'), y = [0,1];
    elseif strcmp(code,'uint8'),   y = [0,255];
    elseif strcmp(code,'uint16'),  y = [0,65535];
    elseif strcmp(code,'int32'),   y = [-2147483647,2147483647];
    elseif strcmp(code,'double'),
       if max(max(f)) > 1, y = [0,255];
       else                y = [0,1];
       end
    else
        fprintf('mmlimits\n')
        f
        error('Does not accept this class:%s',code)
    end





