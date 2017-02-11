function Y = mmcwatershed(f, g, Bc, LINEREG)
% PRG

    if nargin < 4, LINEREG = 'LINES';     end
    if nargin < 3, Bc      = mmsecross(); end

    %%% return g
    %fprintf('starting\n')
    withline = strcmp(LINEREG,'LINES');
    if mmis(g,'binary'),
        g = mmlabel(g,Bc);
        %disp('aaaaaaaaaaaaaaaaaaaaaaaaaa')
        %class(g)
    end
    %fprintf('before 1. mmpad4n\n')
    status = mmpad4se(uint8(zeros(size(f))),Bc, 3);
    f = mmpad4se( f,Bc,0);               % pad input image
    %if max(max(f)) >= 256, error('mmcwatershed:f>=256'); end   % TODO
    f = double(f);                                              % TODO PAS UTILE
    %fprintf('before 2. mmpad4n\n')
    y = mmpad4se( g,Bc,0);               % pad marker image with 0
    %if max(max(y)) >= 256, error('mmcwatershed:y>=256'); end   % TODO
    y = double(y);                                              % TODO UTILE
    if withline,
        y1 = mmintersec(mmbinary(y), 0);
    end
    Lim = mmlimits(f);
    costM = Lim(2) * ones(size(f));      % cummulative cost function image
    mi = find(mmgradm(y,mmsebox(0),Bc)); % 1D index of internal contour of marker
    %fprintf('before put costM\n')
    costM(mi) = 0;
    HQueue = [mi, costM(mi)];            % init hierarquical queue: index,value
    %fprintf('before mmse2list0\n')
    %%% Bi=mmse2list0(f,Bc)              % get 1D displacement neighborhood pixels
    %%% Bi=se2flatidx(f,Bc)              % get 1D displacement neighborhood pixels
    Bi=mmse4linidx(f,Bc);                % get 1D displacement neighborhood pixels
    [x,v] = mmmat2set(Bc);
    %%%fprintf('==========================================\n')
    %%%fprintf(' DEBUT DU WHILE                           \n')
    %%%fprintf('==========================================\n')
    if ~isnrtcall(),
       fprintf('mmcwatershed:while:size(HQueue,1)=      ')
       %fprintf('%6d',size(HQueue,1))
       fprintf('\b\b\b\b\b\b%06d',size(HQueue,1));
    end
    while size(HQueue,1),
        [Min, i] = min(HQueue(:,2));     % i is the index of minimum value
        pi = HQueue(i,1);
        ii = ones(size(HQueue,1),1);
        ii(i) = 0;
        HQueue(i,:) = [];                % remove this pixel from queue
        status(pi) = 1;                  % make it a permanent label
        
        %fprintf('******************************************\n')
        %fprintf(' AVANT LE FOR                             \n')
        %fprintf('******************************************\n')
        %size(pi+Bi)
        piBi = (pi+Bi).';
        % Pour un meme deroulement de programme
        %[M,N] = size(status);
        %[piBi,C_piBi] = csort((pi+Bi).',M,N);
        
        for qi = piBi,                       % for each neighbor of pi
            %%%fprintf('------------------------------------------\n')
            %%%fprintf(' DEBUT DU FOR                             \n')
            %%%fprintf('------------------------------------------\n')
            %%% qi
            if (status(qi) ~= 3),            % not image border
                if (status(qi) ~= 1),        % if not permanent
                    cost_M = max(costM(pi), f(qi));           
                    if cost_M < costM(qi),
                        costM(qi) = cost_M;
                        y(qi) = y(pi);       % propagate the label
                        aux = zeros(size(HQueue) + [1,0]);
                        aux(1:end-1,:) = HQueue;
                        aux(end,:) = [qi, cost_M];
                        HQueue = aux;        % insert pixel in the queue
                    end
                elseif withline,
                    if y(qi) ~= y(pi) && y1(pi) == 0 && y1(qi) == 0,
                        y1(pi) = 1;
                    end
                end
            end
        end
        %%%fprintf('==========================================\n')
        %%%fprintf(' DEBUT DU WHILE                           \n')
        %%%fprintf('==========================================\n')
        if ~isnrtcall(),
           %fprintf('%6d',size(HQueue,1))
           fprintf('\b\b\b\b\b\b%06d',size(HQueue,1));
        end
    end
    if ~isnrtcall(),
       fprintf('\n')
       %fprintf('mmcwatershed:while:size(HQueue,1):END\n')
    end

    if withline,
        Y = y1;
    else
        Y = y;
    end
    Y = mmdepad4se(Y,Bc);
