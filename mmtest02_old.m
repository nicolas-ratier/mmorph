

%-------------------------------------------------
% BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
%-------------------------------------------------
fprintf('======================================\n');
fprintf('        Non-regression testing        \n');
fprintf('======================================\n');

%%% https://mailman.cae.wisc.edu/pipermail/help-octave/2012-November/055101.html
%fprintf(1,'\033[31mThis is a test.\033[36m Here another color...
%\033[37;41;1m Now is background color and white bold.\033[0m\n');

fprintf(1, [char(27),'[31mThis is a test.', ...
            '', ...
             char(27), ...
            '[36m Here another color.', ...
             char(27), ...
            '[37;41;1m Now is background color and white bold.', ...
             char(27), ...
            '[0m\n']);

fprintf(1, [char(27), ...
          '[31mThis is a test.', ...
           char(27), ...
          '[36m Here another color.', ...
           char(27), ...
          '[37;41;1m Now is background color and white bold.', ...
           char(27), ...
          '[0m\n']);



%f = [
%    0 1 1
%    1 1 1
%    0 1 1];
%g = [
%    0 1 1
%    1 1 1
%    0 1 1];
%a =[
%     0     2     2
%     2     2     2
%     0     2     2];
%b =[
%     3     3     3
%     3     3     3
%     2     3     3];
%nrt({a,b},'mmexample',{f,g});



%-------------------------------------------------
% mmbinary
%-------------------------------------------------
a = [0, 1, 2, 3, 4];
%b=mmbinary(a)
b = [0 1 1 1 1];
nrt({b},'mmbinary',{a});

%-------------------------------------------------
% mmbinary
%-------------------------------------------------

b = mmbinary([0, 1, 0, 1]);
%c=mmgray(b)
c = [ 0 255 0 255];
nrt({c},'mmgray',{b});

%d=mmgray(b,'uint8',100)
d = [ 0 100 0 100];
nrt({d},'mmgray',{b,'uint8',100});

%e=mmgray(b,'uint16')
%e = [ 0 65535 0 65535];
%nrt({d},'mmgray',{b,'uint16'});

%>>> f=mmgray(b,'int32',0)
%>>> print f
%[-2147483647           0 -2147483647           0]

%-------------------------------------------------
% mmdrawv
%-------------------------------------------------

%-------------------------------------------------
% END END END END END END END END END END END END
%-------------------------------------------------
fprintf('\n');
fprintf('======================================\n');
fprintf('                SUCCES                \n');
fprintf('======================================\n');

