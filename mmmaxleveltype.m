function max = mmmaxleveltype(TYPE)

    if nargin == 0, TYPE = 'uint8'; end

    %%%max = 0;
    if     strcmp(TYPE,'binary'), max =          1;
    elseif strcmp(TYPE,'uint8'),  max =        255;
    elseif strcmp(TYPE,'uint16'), max =      65535;
    elseif strcmp(TYPE,'int32'),  max = 2147483647;
    elseif strcmp(TYPE,'double'), max =        255;
    else
        error('does not support this data type: ''%s''',TYPE);
    end
