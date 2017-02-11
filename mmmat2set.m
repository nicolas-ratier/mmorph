function [x,y] = mmmat2set(A)

    % if len(A.shape) == 1: A = A[NewAxis,:]     % TODO

    Lim = mmlimits(A);
    offsets = find(A.'(:).' - Lim(1)) - 1;
    %if len(offsets) == 0: return ([],[])        % TODO

    [h,w] = size(A);
    x(1,:) = floor(offsets/w) - floor((h-1)/2);
    x(2,:) = rem  (offsets,w) - floor((w-1)/2);
    x = transpose(x);

    B = A.'(:).';
    y = B(offsets+1);
