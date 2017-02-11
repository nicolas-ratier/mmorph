function y = mminfcanon(f, Iab, theta, DIRECTION)

    if nargin < 4, DIRECTION = 'CLOCKWISE'; end
    if nargin < 3, theta     = 45;          end

    DIRECTION = upper(DIRECTION);
    y = mmunion(f,1);
    for t = 0:theta:360-theta,
        Irot = mminterot( Iab, t, DIRECTION );
        y    = mmintersec( y, mminfgen(f, Irot));
    end