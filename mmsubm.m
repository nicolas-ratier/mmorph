function y = mmsubm( f1, f2 ) 

%    if type(f2) is array:          TODO
%        assert f1.typecode() == f2.typecode(), 'Cannot have different datatypes:'

    %disp('============= mmsubm ================')    
    %f1
    %class(f1)
    %f2
    %class(f2)

    Lim = mmlimits(f1);
    y   = min(max(f1-f2, Lim(1)), Lim(2));

    %%% y = imsubtract(f1,f2);