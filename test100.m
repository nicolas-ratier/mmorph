%http://www.developpez.net/forums/d1091482/environnements-developpement/
%matlab/interfaces-graphiques/afficher-barre-progression-l-execution/

%clc
%fprintf('%03d%%',0);
%for n=1:50
%    fprintf('%c%c%c%c%03d%%',8,8,8,8,round(100*(n/50)));
%    pause(.05);
%end
%fprintf('\n');

%clc
fprintf('%03d%%',0);
for n=1:50
    fprintf('\b\b\b\b%03d%%',round(100*(n/50)));
    pause(.05);
end
fprintf('\n');