function B = mmimg2se(fd, FLAT, f)

    if     nargin == 1, FLAT = 'FLAT';
    elseif nargin == 2, error('The function must have 1 or 3 parameters')
    end

    if ~mmisbinary(fd), error('First parameter must be binary'); end

    FLAT = upper(FLAT);
    if strcmp(FLAT,'FLAT'),
        B = mmseshow(fd);
    else
        %Lim = mmlimits(int32([0]));                    TODO
        %B = choose(fd, (Lim(1)*ones(size(fd)),f) )
        %B = mmseshow(int32(B),'NON-FLAT');
        %disp('TODO')
        B = 1;
    end
    
