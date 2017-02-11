function nrt(varargin)
% Non-regression testing
global NRT_COL
global NRT_NBR
global NRT_SUM

% Initialisation du compteur pour l'impression du resultat des tests
%if isempty(NbCol)
%   NbCol = 0;
%end

ap  = varargin{1};
Fct = varargin{2};
b   = varargin{3};

if nargin == 4 && strcmp(varargin{4},'not yet'),
   NOTYET = 1; 
else
   NOTYET = 0;
end

% Parametres d'entree : b{1},b{2},b{3}
if length(b) >= 1,
   InParam = '';
   for K = 1:length(b),
      InParam = strcat(InParam,'b{',num2str(K),'},');
   end
   InParam(end) = '';
end

% Parametres de sortie : [a{1},a{2}]
ResParam = '[';
for K = 1:length(ap),
   ResParam = strcat(ResParam,'a{',num2str(K),'},');
end
ResParam(end) = ']';

% Commande a evaluer
% Command = '[a{1},a{2}] = feval(Fct)'
% Command = '[a{1},a{2}] = feval(Fct,b{1},b{2},b{3})'
if     length(b) == 0,
   eval(strcat(ResParam,' = feval(Fct);'));
elseif length(b) >= 1,
   eval(strcat(ResParam,' = feval(Fct,',InParam,');'));
end

Res = 1;
Sum = 0;
% Comparaison des resultats
for K = 1:length(ap),
   %if isnumeric(a{K}), % NE MARCHE QUE POUR LES ENTIERS TODO
      %%% Res = Res & all(all(a{K} == ap{K}));
      Res = Res & isequal(a{K},ap{K});
      Sum = Sum + prod(size(a{K}));
   %else
   %   error('comparaison pas encore pris en compte');
   %end
end

% Nombre de nombre teste
NRT_NBR = NRT_NBR + 1;
NRT_SUM = NRT_SUM + Sum;

% Blanc ou Saut de ligne pour formater les resultats
NRT_COL = NRT_COL + 1;
if NRT_COL ~= 1 && mod(NRT_COL-1,10) == 0, fprintf('|');  end

%if mod(NRT_COL-1,10) == 0, fprintf('|');  end
%if mod(NRT_COL-1,30) == 0 && NRT_COL ~= 1,         % Ordre a changer
%   fprintf('\n');
%   fprintf('|');
%end
%if mod(NRT_COL-1,10*30) == 0 && NRT_COL ~= 1,         % Ordre a changer
%   fprintf('==========|==========|==========|');
%   fprintf('\n');
%   fprintf('|');
%end

% Impression du resultat
if Res == 1,
   if NOTYET,
      pr('?',Res);
   else
      fprintf('.',Res);
   end
else,
   if NOTYET,
      pr('X',Res);
   else
      pr('*',Res);
      %fprintf('\n');
      %fprintf('#######################################\n',Fct);
      %fprintf('ERROR: <Results don''t match> %s\n',Fct);
      %fprintf('#######################################\n',Fct);
   end
end


