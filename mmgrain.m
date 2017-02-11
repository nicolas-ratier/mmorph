function y = mmgrain(fr, f, measurement, option)

    if nargin < 4, option = 'image'; end

    measurement = upper(measurement);
    option      = upper(option);

    %%% if len(fr.shape) == 1: fr = fr[NewAxis,:]

    n = max(max(fr));
    if strcmp(option,'DATA'),
       y = [];
    else
       y = zeros(size(fr));
    end

    if strcmp(measurement,'MAX'),
        for i = 1:n,
            aux = fr == i;
            val = max(max(aux.*f));
            if strcmp(option,'DATA'), y(i,:) = val;
            else                      y(aux) = val;
            end
        end

    elseif strcmp(measurement,'MIN'),
        for i = 1:n,
            aux = fr == i;
            lin = aux.*f;
            ind = find(aux);
            val = min(lin(ind));
            if strcmp(option,'DATA'), y(i,:) = val;
            else                      y(ind) = val;
            end
        end

    elseif strcmp(measurement,'SUM'),
        for i = 1:n,
            aux = fr == i;
            val = sum(sum(aux.*f));
            if strcmp(option,'DATA'), y(i,:) = val;
            else                      y(aux) = val;
            end
        end

    elseif strcmp(measurement,'MEAN'),
        for i = 1:n,
            aux = fr == i;
            lin = aux.*f;
            ind = find(aux);
            val = mean(lin(ind));
            if strcmp(option,'DATA'), y(i,:) = val;
            else                      y(ind) = val;
            end
        end

    elseif strcmp(measurement,'STD'),
        for i = 1:n,
            aux = fr == i;
            lin = aux.*f;
            ind = find(aux);
            v   = lin(ind);
            if length(v) < 2, val = 0;
            else              val = std(v);
            end
            if strcmp(option,'DATA'), y(i,:) = val;
            else                      y(ind) = val;
            end
        end

    elseif strcmp(measurement,'STD1'),
        error('''STD1'' is not implemented')
    else
        error('Measurement should be ''MAX'', ''MIN'', ''MEAN'', ''SUM'', ''STD'', ''STD1''.')
    end

    %if option == 'DATA':
    %    y = array(y)
    %    if len(y.shape) == 1: y = y[:,NewAxis]
    %return y