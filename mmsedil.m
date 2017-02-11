function Bo = mmsedil(B1, B2)

    % assert ((mmdatatype(B1) == 'binary') or (mmdatatype(B1) == 'int32')) and (
    %         (mmdatatype(B2) == 'binary') or (mmdatatype(B2) == 'int32')),'SE must be binary or int32'

%    if len(B1.shape) == 1: B1 = B1[NewAxis,:]                               TODO
%    if len(B2.shape) == 1: B2 = B2[NewAxis,:]
%    if (mmdatatype(B1) == 'int32') or (mmdatatype(B2) == 'int32'):
%       Bo = int32([mmlimits(int32([0]))[0]])
%       if mmdatatype(B1) == 'binary':
%          B1 = mmgray(B1,'int32',0)
%       if mmdatatype(B2) == 'binary':
%          B2 = mmgray(B2,'int32',0)
%    else:
%       Bo = mmbinary([0])

    Bo    = 0;                          % TODO 
    [x,v] = mmmat2set(B2);
   %%% if len(x):                       % TODO
        [M,N] = size(x);
        for m = 1:M,
            %%% s  = mmadd4dil(B1,v(m))
            %%% st = mmsetrans(s,x(m,:))
            st = mmsetrans(B1,x(m,:));
            Bo = mmseunion(Bo,st);
        end
    