function y = mmero( f, b ) 

    if nargin < 2, b = mmsecross(); end


    %disp('=========== mmero ==============')
    %AA0 = f
    %AAA = mmneg(f)
    %BBB = mmsereflect(b)
    %CCC = mmdil(mmneg(f),mmsereflect(b))
    %DDD = mmneg(mmdil(mmneg(f),mmsereflect(b)))


    y = mmneg(mmdil(mmneg(f),mmsereflect(b)));






%if nargin < 2,
%  b = [[0,1,0],
%       [1,1,1],
%       [0,1,0]];
%end

%f = double(f);
%b = double(b);
%y = imerode(f,b);