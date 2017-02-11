function y = mmstats(f, measurement)

    measurement = upper(measurement);
    if     strcmp(measurement,'MAX'),
        y = max(f(:));
    elseif strcmp(measurement,'MIN'),
        y = min(f(:));
    elseif strcmp(measurement,'MEAN'),
        y = mean(f(:));
    elseif strcmp(measurement,'MEDIAN'),
        y = median(f(:));
    elseif strcmp(measurement,'STD'),
        y = std(f(:));
    else
        error('Not a valid measurement')
    end