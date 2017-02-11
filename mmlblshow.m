function y = mmlblshow(f, option)

    if nargin < 2, option = 'noborder'; end

    if mmisbinary(f) | (length(size(f)) ~= 2),
      error('Error, mmlblshow: works only for grayscale labeled image')
    end

    option = upper(option);
    if     strcmp(option,'NOBORDER'),
      border = 0.0;
    elseif strcmp(option,'BORDER'),
      border = 1.0;
    else
      error('Error: option must be BORDER or NOBORDER')
    end
    y = mmglblshow(f, border);
