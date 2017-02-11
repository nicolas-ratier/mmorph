function Y = mmcwatershed(f, g, Bc, LINEREG)

    if nargin < 4, LINEREG = 'LINES';     end
    if nargin < 3, Bc      = mmsecross(); end

    %%% return g
    printf('starting\n')
    withline = strcmp(LINEREG,'LINES');
    if mmis(g,'binary'),
        g = mmlabel(g,Bc);
    end
    g
    printf('before 1. mmpad4n\n')
    status = mmpad4se(uint8(zeros(size(f))),Bc, 3);
    status
    f = mmpad4se( f,Bc,0);               %pad input image
    f
    printf('before 2. mmpad4n\n')
    y = mmpad4se( g,Bc,0);               % pad marker image with 0
    y
    if withline,
        y1 = mmintersec(mmbinary(y), 0);
        y1
    end
    Lim = mmlimits(f);
    costM = Lim(2) * ones(size(f));      % cummulative cost function image
    costM
    mi = find(mmgradm(y,mmsebox(0),Bc)); % 1D index of internal contour of marker
    mi
    printf('before put costM\n')
    costM(mi) = 0;
    costM
    HQueue = [mi, costM(mi)];            % init hierarquical queue: index,value
    HQueue
    printf('before mmse2list0\n')
    %%% print "f=",f
    %%% print "Bc",Bc
    %%% Bi=mmse2list0(f,Bc)              % get 1D displacement neighborhood pixels
    %%% Bi=se2flatidx(f,Bc)              % get 1D displacement neighborhood pixels
    %%% Bi = array([-9,-1,0,1,9])
    Bi=mmse4linidx(f,Bc);                % get 1D displacement neighborhood pixels
    Bi
    [x,v] = mmmat2set(Bc);
    x
    v
    printf('==========================================\n')
    printf(' DEBUT DU WHILE                           \n')
    printf('==========================================\n')
    HQueue
    while size(HQueue,1),
        [Min, i] = min(HQueue(:,2));     % i is the index of minimum value
        i
        pi = HQueue(i,1);
        pi
        ii = ones(size(HQueue,1),1);
        ii(i) = 0;
        ii 
        HQueue(i,:) = [];                % remove this pixel from queue
        HQueue
        status(pi) = 1;                  % make it a permanent label
        status
        
        printf('******************************************\n')
        printf(' AVANT LE FOR                             \n')
        printf('******************************************\n')
        pi+Bi
        %%% piBi = (pi+Bi).'
        % Pour un meme deroulement de programme
        [M,N] = size(status);
        [piBi,C_piBi] = csort((pi+Bi).',M,N);
         piBi
         C_piBi
        
        for qi = piBi,                       % for each neighbor of pi
            printf('------------------------------------------\n')
            printf(' DEBUT DU FOR                             \n')
            printf('------------------------------------------\n')
            qi
            printf('status(qi)='), status(qi)
            if (status(qi) ~= 3),            % not image border
                if (status(qi) ~= 1),        % if not permanent
                    cost_M = max(costM(pi), f(qi))
                    printf('costM(qi) ='), costM(qi)
                    printf('f(qi)     ='), f(qi)
                    cost_M           
                    if cost_M < costM(qi),
                        qi
                        costM(qi) = cost_M;
                        costM
                        y(qi) = y(pi);       % propagate the label
                        y
                        aux = zeros(size(HQueue) + [1,0]);
                        aux
                        aux(1:end-1,:) = HQueue;
                        aux
                        aux(end,:) = [qi, cost_M];
                        aux
                        HQueue = aux         % insert pixel in the queue
                        HQueue
                    end
                elseif withline,
                    if y(qi) ~= y(pi) && y1(pi) == 0 && y1(qi) == 0,
                        y1(pi) = 1
                    end
                end
            end
        end
        printf('==========================================\n')
        printf(' DEBUT DU WHILE                           \n')
        printf('==========================================\n')
        HQueue
    end

    if withline,
        Y = y1
    else
        Y = y
    end
    Y = mmdepad4se(Y,Bc);
