function y = mmblob(fr, measurement, option)

    if nargin < 3, option = 'image'; end

    measurement = upper(measurement);
    option      = upper(option);

    %%% if len(fr.shape) == 1: fr = fr[NewAxis,:]

    n = max(max(fr));
    if strcmp(option,'DATA'),
       y = [];
    else
       y = zeros(size(fr));
    end

    [M,N] = size(fr);
    if strcmp(measurement,'AREA'),
        for i = 1:n,
            aux  = fr == i;
            area = sum(sum(aux));
            if strcmp(option,'DATA'), y(i,:) = area;
            else                      y      = y + area*aux;
            end
        end

    elseif strcmp(measurement,'CENTROID'),
        for i = 1:n,
            aux  = fr == i;
            ind  = find(aux);
            indx = rem  ((ind-1),M)+1;
            indy = floor((ind-1)/M)+1;
            centroid = [floor(sum(indx-1)/length(ind))+1, 
                        floor(sum(indy-1)/length(ind))+1];
            if strcmp(option,'DATA'), y(i,:) = centroid;
            else                      y(centroid(1),centroid(2)) = 1;
            end
        end

    elseif strcmp(measurement,'BOUNDINGBOX'),
        for i = 1:n,
            aux = fr == i;
            aux1 = sum(aux,1) >= 1;       % OR sur toutes les lignes
            aux2 = sum(aux,2) >= 1;       % OR sur toutes les colonnes
            row = find(aux2);
            col = find(aux1);
            if strcmp(option,'DATA'),
                y(i,:) = [row(1) col(1) row(end) col(end)];
            else
                y(row(1):row(end),col(1)  ) = 1;
                y(row(1):row(end),col(end)) = 1;
                y(row(1),  col(1):col(end)) = 1;
                y(row(end),col(1):col(end)) = 1;
            end
        end

    else
        error('Measurement option should be ''AREA'',''CENTROID'', or ''BOUNDINGBOX''.')
    end

    %if strcmp(option,'DATA'),
    %    y = array(y)
    %    if len(y.shape) == 1: y = y[:,NewAxis]
    %end
