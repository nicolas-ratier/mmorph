function y = mmaddm( f1, f2 )
% Addition of two images, with saturation.

    if ~isscalar(f2),       % DIFF: if type(f2) is array:
      assert(strcmp(class(f1),class(f2)),'Cannot have different datatypes:')
    end
    Lim = mmlimits(f1);
    y   = max(min(f1+f2,Lim(2)),Lim(1));    % max, min pas utile avec Octave




%%% y = imadd(f1,f2);