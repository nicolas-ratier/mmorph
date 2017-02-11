function M = mmset2mat(x, v)

    if nargin < 2, v = ones(size(x,1),1)'; end

    %%% if len(x) == 0:  return array([0]).astype(v.typecode())    % TODO
    %%% if len(x.shape) == 1: x = x[NewAxis,:]                     % TODO

    %disp('-----------------------')
    %disp('Bonne Taille de Matrice')
    %disp('-----------------------')
    dh = max(abs(x(:,1)));
    dw = max(abs(x(:,2)));
    h  = (2*dh)+1;
    w  = (2*dw)+1;
    
    M      = zeros(h,w);            % mmlimits(v) est inutile NON!!! TODO
    %offset = x(:,1)*w + x(:,2) + (dh*w + dw) + 1;    % Numerotation par ligne
    offset = x(:,1) + x(:,2)*h + (dh + dw*h) + 1;     % Numerotation par colonne
    M(offset) = v;

