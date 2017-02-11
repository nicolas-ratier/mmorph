function Data = nrtReadData(FileName,Var,Pos)

if nargin < 3, Pos = 1; end

%FileName = 'mmbinary02.txt';
%Var = 'a';
%Pos = 2;

POS   = 0;
BEGIN = 0;
Data  = '';

fid = fopen(FileName,'rt');
tline = fgetl(fid);
while ischar(tline)
   % Fin definition de la matrice
   if BEGIN && strcmp(tline(1:3),'>>>'),
      BEGIN = 0;
   end
   
   % Construire la chaine
   if BEGIN,
      Data = strcat(Data,tline);
   end   
   
   % Debut definition de la matrice
   if strcmp(sscanf(tline,'>>> print %s'),Var),
      POS = POS + 1;
      if POS == Pos,
         BEGIN = 1;
      end
   end

   tline = fgetl(fid);
end
fclose(fid);

if strcmp(Data,''), error('nrtData: Data is void'); end

Data = strrep(Data,']','];');
Data = eval(Data);