function Y = mmcwatershed(f, g, Bc=None, LINEREG="LINES")

    if Bc is None: Bc = mmsecross()
    return g
    print 'starting'
    withline = (LINEREG == 'LINES')
    if mmis(g,'binary'):
        g = mmlabel(g,Bc)
    print 'before 1. mmpad4n'
    status = mmpad4n(uint8(zeros(f.shape)),Bc, 3)
    f = mmpad4n( f,Bc,0)                          % pad input image
    print 'before 2. mmpad4n'
    y = mmpad4n( g,Bc,0)                          % pad marker image with 0
    if withline:
        y1 = mmintersec(mmbinary(y), 0)
    costM = mmlimits(f)[1] * ones(f.shape)        % cummulative cost function image
    mi = nonzero(mmgradm(y,mmsebox(0),Bc).flat)   % 1D index of internal contour of marker
    print 'before put costM'
    put(costM.flat,mi, 0)
    HQueue=transpose([mi, take(costM.flat, mi)])  % init hierarquical queue: index,value
    print 'before mmse2list0'
    Bi=mmse2list0(f,Bc)                           % get 1D displacement neighborhood pixels
    x,v = mmmat2set(Bc)
    while HQueue:
        print 'Hq=',HQueue
        i = argmin(HQueue[:,1])                   % i is the index of minimum value
        print 'imin=',i
        pi = HQueue[i,0]
        print 'pi=',pi
        ii = ones(HQueue.shape[0])
        ii[i] = 0
        print 'ii=',ii
        HQueue = transpose(array([compress(ii,HQueue[:,0]),
                                  compress(ii,HQueue[:,1])])) # remove this pixel from queue
        print 'H=',HQueue
        put(status.flat, pi, 1)                   % make it a permanent label
        for qi in pi+Bi :                         % for each neighbor of pi
            if (status.flat[qi] ~= 3):            % not image border
                if (status.flat[qi] ~= 1):        % if not permanent
                    cost_M = max(costM.flat[pi], f.flat[qi])
                    if cost_M < costM.flat[qi]:
                        print 'qi=',qi
                        costM.flat[qi] = cost_M
                        y.flat[qi] = y.flat[pi]                  % propagate the label
                        aux = zeros(array(HQueue.shape) + [1,0])
                        aux[:-1,:] = HQueue
                        aux[-1,:]=[qi, cost_M]
                        HQueue = aux # insert pixel in the queue
                        print 'insert H=',HQueue
                elif (withline        and
                     (y.flat[qi] ~= y.flat[pi]) and
                     (y1.flat[pi] == 0)    and
                     (y1.flat[qi] == 0)     ):
                    y1.flat[pi] = 1
    if withline:
        Y = y1
    else:
        Y = y
    return Y