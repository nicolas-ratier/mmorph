function y = mmsupcanon(f, Iab, theta, DIRECTION)

    if nargin < 4, DIRECTION = 'CLOCKWISE'; end
    if nargin < 3, theta     = 45;          end

    DIRECTION = upper(DIRECTION);
    y = mmintersec(f,0);
    for t = 0:theta:360-theta,
        Irot = mminterot( Iab, t, DIRECTION );
        y    = mmunion( y, mmsupgen(f, Irot));
    end
