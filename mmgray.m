function y = mmgray(f, TYPE, k1)

    if nargin < 2, TYPE = 'uint8';              end
    if nargin < 3, k1   = mmmaxleveltype(TYPE); end
    %if type(f) is list: f = mmbinary(f)

    %assert(mmis(f,'binary'),'f must be binary')

    if     strcmp(TYPE,'uint8'),  y = uint8 (k1*f);
    elseif strcmp(TYPE,'uint16'), y = uint16(k1*f);
    elseif strcmp(TYPE,'int32'),  y = int32 (k1*f) - int32(mmneg(f)*mmmaxleveltype(TYPE));
    elseif strcmp(TYPE,'double'), y = k1*f;
    else
        fprintf('mmgray\n')
        f
        error('Does not accept this class:%s',TYPE)
    end


%if nargin < 3, k1 = 255; end
%y = k1*f;