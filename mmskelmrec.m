function y = mmskelmrec(f, B)

    if nargin < 2, B = mmsecross(); end

    y = mmbinary(mmintersec(f, 0));
    for r = max(max(f)):-1:2,
        y = mmdil(mmunion(y,mmbinary(f,r)), B);
    end
    y = mmunion(y, mmbinary(f,1));
