function B =  mmseunion(B1, B2)

    %%% assert B1.typecode() == B2.typecode(), 'Cannot have different datatypes:'

    %if len(B1) == 0: return B2                    % TODO
    %if len(B1.shape) == 1: B1 = B1[NewAxis,:]     % TODO
    %if len(B2.shape) == 1: B2 = B2[NewAxis,:]     % TODO

    if ~isequal(size(B1),size(B2)),
        Lim = mmlimits(B1);
        inf = Lim(1);

        [h1,w1] = size(B1);
        [h2,w2] = size(B2);

        H = max(h1,h2);
        W = max(w1,w2);
        Hc = (H-1)/2;    % center
        Wc = (W-1)/2;    % center
        BB1 = B1;
        BB2 = B2;
        B1 = inf*ones(H,W); 
        B2 = inf*ones(H,W);
        dh1s = (h1-1)/2;
        dh1e = (h1-1)/2 + mod(h1+1,2); % deal with even and odd dimensions
        dw1s = (w1-1)/2; 
        dw1e = (w1-1)/2 + mod(w1+1,2);
        dh2s = (h2-1)/2; 
        dh2e = (h2-1)/2 + mod(h2+1,2);
        dw2s = (w2-1)/2; 
        dw2e = (w2-1)/2 + mod(w2+1,2);

        B1( Hc-dh1s+1 : Hc+dh1e+1  ,  Wc-dw1s+1 : Wc+dw1e+1 ) = BB1;
        B2( Hc-dh2s+1 : Hc+dh2e+1  ,  Wc-dw2s+1 : Wc+dw2e+1 ) = BB2;
    end
    B = max(B1,B2);