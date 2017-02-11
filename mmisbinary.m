function bool = mmisbinary(f)

    code = class(f);
    if     strcmp(code,'logical'), bool = 1; %fprintf('A1')
    elseif strcmp(code,'uint8'),   bool = 0; %fprintf('A2')
    elseif strcmp(code,'uint16'),  bool = 0; %fprintf('A3')
    elseif strcmp(code,'int32'),   bool = 0; %fprintf('A4')
    elseif strcmp(code,'double'),
       if max(max(f)) == 1, bool = 1;
       else                 bool = 0;
       end
    else
        fprintf('mmisbinary\n')
        f
        error('Does not accept this class:%s',code)
    end


%    if max(max(f)) == 1,            
%       bool = 1;
%    else
%       bool = 0;
%    end