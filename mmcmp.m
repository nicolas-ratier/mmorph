function y = mmcmp(f1, oper, f2, oper1, f3)

    if     oper == '==', y = (f1==f2);
    elseif oper == '~=', y = (f1~=f2);
    elseif oper == '<=', y = (f1<=f2);
    elseif oper == '>=', y = (f1>=f2);
    elseif oper == '>',  y = (f1> f2);
    elseif oper == '<',  y = (f1< f2);
    else
        error('oper must be one of: ==, ~=, >, >=, <, <=');        %%%% , it was:'+oper
    end

    if nargin == 5,
        if     oper1 == '==', y = mmintersec(y, f2==f3);
        elseif oper1 == '~=', y = mmintersec(y, f2~=f3);
        elseif oper1 == '<=', y = mmintersec(y, f2<=f3);
        elseif oper1 == '>=', y = mmintersec(y, f2>=f3);
        elseif oper1 == '>',  y = mmintersec(y, f2> f3);
        elseif oper1 == '<',  y = mmintersec(y, f2< f3);
        else
            error('oper1 must be one of: ==, ~=, >, >=, <, <=');   %%%% , it was:'+oper1
        end
    end