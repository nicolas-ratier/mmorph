function y = mmis(f1, oper, f2, oper1, f3)

    if nargin == 2,
        oper = upper(oper);
        if     strcmp(oper,'BINARY'), y =  mmisbinary(f1);
        elseif strcmp(oper,'GRAY')  , y = ~mmisbinary(f1);
        else
            error('oper should be BINARY or GRAY, it was:%s',oper)
        end

    elseif nargin >= 3,
        if     oper == '==', y =  mmisequal(f1, f2);
        elseif oper == '~=', y = ~mmisequal(f1,f2);
        elseif oper == '<=', y = mmislesseq(f1,f2);
        elseif oper == '>=', y = mmislesseq(f2,f1);
        elseif oper == '>',  y = mmisequal(mmneg(mmthreshad(f2,f1)),mmbinary(1));
        elseif oper == '<',  y = mmisequal(mmneg(mmthreshad(f1,f2)),mmbinary(1));
        else
            error('oper must be one of: ==, ~=, >, >=, <, <=, it was:%s',oper)
        end

    elseif nargin == 5,
        if     oper1 == '==', y = y &   mmisequal(f2,f3);
        elseif oper1 == '~=', y = y & (~mmisequal(f2,f3));
        elseif oper1 == '<=', y = y & mmislesseq(f2,f3);
        elseif oper1 == '>=', y = y & mmislesseq(f3,f2);
        elseif oper1 == '>',  y = y & mmisequal(mmneg(mmthreshad(f3,f2)),mmbinary(1));
        elseif oper1 == '<',  y = y & mmisequal(mmneg(mmthreshad(f2,f3)),mmbinary(1));
        else
            error('oper1 must be one of: ==, ~=, >, >=, <, <=, it was:%s',oper1)
        end
    end
