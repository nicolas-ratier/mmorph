function Irot = mminterot(Iab, theta, DIRECTION)

    if nargin < 3, DIRECTION = "CLOCKWISE"; end
    if nargin < 2, theta     = 45;          end

    DIRECTION = upper(DIRECTION);
    [A,Bc] = Iab{:};
    if ~strcmp(DIRECTION,'CLOCKWISE')
        theta = 360 - theta;
    end
    Irot = mmse2hmt(mmserot(A, theta),
                    mmserot(Bc,theta));
