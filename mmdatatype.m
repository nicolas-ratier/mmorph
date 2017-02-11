function type = mmdatatype(f)
%
% logical:   Logical array of true and false values  [0,1]
%   uint8:   8-bit unsigned integer array            [0,255]
%  uint16:  16-bit unsigned integer array            [0,65535]
%  uint32:  32-bit unsigned integer array            [0,4294967295]
%  uint64:  64-bit unsigned integer array
%    int8:   8-bit signed integer array              [-128,127]
%   int16:  16-bit signed integer array              [-32768,32767]
%   int32:  32-bit signed integer array              [-2147483648,2147483647]
%   int64:  64-bit signed integer array
%  single:  Single-precision floating point number array
%  double:  Double-precision floating point number array

    code = class(f);
    if     strcmp(code,'logical'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code,  'uint8'), type = 'uint8';
    elseif strcmp(code, 'uint16'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code, 'uint32'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code, 'uint64'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code,   'int8'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code,  'int16'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code,  'int32'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code,  'int64'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code, 'single'), error('The class ''%s'' is not used in mmorph',code);
    elseif strcmp(code, 'double'), type = 'double';
    else
        error('Does not accept this class')
    end






