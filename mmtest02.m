%==============================================================================
%                           Non-Regression Testing
%------------------------------------------------------------------------------
%
%------------------------------------------------------------------------------
% addpath('/usr/share/octave/packages/image-2.0.0/')
%==============================================================================
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

global NRT_COL
global NRT_NBR
global NRT_SUM
NRT_COL = 0;
NRT_NBR = 0;
NRT_SUM = 0;
t_begin = cputime;

t1 = now;
t2 = addtodate(t1, 15, 'minute');
t2 = addtodate(t2, 12, 'second');

pcc(sprintf('----------------------------------\n'))
pcc(sprintf('| Begin  : %s  |\n',datestr(t1)))
pcc(sprintf('| End (~):             %s  |\n',datestr(t2,13)))
pcc(sprintf('----------------------------------\n'))

%%% fprintf('|         1 1111111112 2222222223|\n')
%%% fprintf('|1234567890 1234567890 1234567890|\n')
%%% fprintf('----------------------------------\n')

%==================================================================================================
% Data Type Conversion
%==================================================================================================
 
%'01 - Data Type Conversion              :'
%'02 - Image Creation                    :'
%'03 - Image Information and Manupulation:'
%'04 - Image file IO                     :'
%'05 - Relations                         :'
%'06 - Operations                        :'
%'07 - Structuring Elements              :'
%'08 - Dilations And Erosions            :'
%'09 - Morphological Filters             :'
%'10 - Image Transforms                  :'
%'11 - Connected Operators               :'
%'12 - Residues                          :'
%'13 - Intervals                         :'
%'14 - Sup-generating And Inf-generating :'
%'15 - Thinning And Thickening           :'
%'16 - Measurements                      :'

NRT_COL = 0;
fprintf('  ')
pb('01:')
%------------------------------------------------------------------------------
%                                       mmbinary 
%------------------------------------------------------------------------------

a = [0, 1, 2, 3, 4];
%>>> b=mmbinary(a)
b = [0 1 1 1 1];
nrt({b},'mmbinary',{a});

a=mmreadgray('../Data/mm3.tif');
%>>> b=mmbinary(a,82);
b = nrtReadData('../nrtData/01 - Data Type Conversion/mmbinary.txt','b');
nrt({b},'mmbinary',{a,82});

%------------------------------------------------------------------------------
%                                      mmfreedom 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                         mmgray 
%------------------------------------------------------------------------------

b = mmbinary([0, 1, 0, 1]);

%>>> c=mmgray(b)
c = [ 0 255 0 255];
nrt({c},'mmgray',{b});

%>>> d=mmgray(b,'uint8',100)
d = [ 0 100 0 100];
nrt({d},'mmgray',{b,'uint8',100});

%>>> e=mmgray(b,'uint16')
e = [ 0 65535 0 65535];
nrt({e},'mmgray',{b,'uint16'});

%>>> f=mmgray(b,'int32',0)
f = [-2147483647 0 -2147483647 0];
nrt({f},'mmgray',{b,'int32',0});

%------------------------------------------------------------------------------
%                                          int32 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                          uint8 
%------------------------------------------------------------------------------

a = int32([-3,0,8,600]);
%>>>  uint8(a)
b = [  0   0   8 255];
nrt({b},'uint8',{a});

%------------------------------------------------------------------------------
%                                         uint16 
%------------------------------------------------------------------------------

a = int32([-3,0,8,100000]);
%>>>  uint16(a)
b = [    0     0     8 65535];
nrt({b},'uint16',{a});

%==================================================================================================
% Image Creation
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('02:')
%------------------------------------------------------------------------------
%                                        mmframe 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                        mmdrawv 
%------------------------------------------------------------------------------

f=uint8(zeros(3,5));
pcoords=uint16([[1,1],
                [1,3],
                [3,5]]);
pvalue=uint16([1,2,3]);

%>>> mmdrawv(f,pcoords,pvalue,'point')
r = [[1 0 2 0 0]
     [0 0 0 0 0]
     [0 0 0 0 3]];
nrt({r},'mmdrawv',{f,pcoords,pvalue,'point'});

%>>> mmdrawv(f,pcoords,pvalue,'line')
r = [[1 1 2 0 0]
     [0 0 0 2 0]
     [0 0 0 0 2]];
nrt({r},'mmdrawv',{f,pcoords,pvalue,'line'});

rectcoords=uint16([1,1,3,4]);
%>>> print mmdrawv(f,rectcoords, uint16(5),'rect')
r = [[5 5 5 5 0]
     [5 0 0 5 0]
     [5 5 5 5 0]];
nrt({r},'mmdrawv',{f,rectcoords, uint16(5),'rect'});

frectcoords=uint16([1,1,3,4]);
%>>> print mmdrawv(f,frectcoords, uint16(5),'rect')
r = [[5 5 5 5 0]
     [5 5 5 5 0]
     [5 5 5 5 0]];
nrt({r},'mmdrawv',{f,frectcoords, uint16(5),'filledrect'});

f  = mmreadgray('../Data/blob3.tif');
f  = transpose(f);                             % Lecture dans le sens du fortran
pc = mmblob(mmlabel(f),'centroid','data');
pc = [pc(:,2),pc(:,1)];
f = transpose(f);
%>>> lines=mmdrawv(mmintersec(f,0),pc,uint8(1),'line')
lines = nrtReadData('../nrtData/02 - Image Creation/mmdrawv.txt','lines');
nrt({lines},'mmdrawv',{mmintersec(f,0),pc,uint8(1),'line'});
%>>> mmshow(f,lines)

%------------------------------------------------------------------------------
%                                         mmtext 
%------------------------------------------------------------------------------

%==================================================================================================
% Image Information and Manipulation
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('03:')
%------------------------------------------------------------------------------
%                                       mmconcat 
%------------------------------------------------------------------------------

f1=mmreadgray('../Data/cameraman.tif');
f2=mmreadgray('../Data/blob.tif');
%>>> g=mmconcat('W',f1,mmgray(mmneg(f2)))
g = nrtReadData('../nrtData/03 - Image Information and Manupulation/mmconcat.txt','g');
nrt({g},'mmconcat',{'W',f1,mmgray(mmneg(f2))});
%>>> mmshow(g);

%------------------------------------------------------------------------------
%                                       mmlimits 
%------------------------------------------------------------------------------

%>>> mmlimits(mmbinary([0, 1, 0]))
r = [0 1];
nrt({r},'mmlimits',{mmbinary([0, 1, 0])});

%>>> mmlimits(uint8([0, 1, 2]))
r = [  0 255];
nrt({r},'mmlimits',{uint8([0, 1, 2])});

%------------------------------------------------------------------------------
%                                 mmmaxleveltype 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                     mmdatatype 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                      mmmat2set 
%------------------------------------------------------------------------------

f=uint8([[1,2,3];[4,5,6];[7,8,9]]);
%>>> i,v=mmmat2set(f)
i = ...
[[-1 -1]
 [-1  0]
 [-1  1]
 [ 0 -1]
 [ 0  0]
 [ 0  1]
 [ 1 -1]
 [ 1  0]
 [ 1  1]];
v = ...
[1 2 3 4 5 6 7 8 9];
nrt({i,v},'mmmat2set',{f});

f=uint8([[1,2,3,4];[5,6,7,8]]);
%>>> i,v=mmmat2set(f)
i = ...
[[ 0 -1]
 [ 0  0]
 [ 0  1]
 [ 0  2]
 [ 1 -1]
 [ 1  0]
 [ 1  1]
 [ 1  2]];
v = ...
[1 2 3 4 5 6 7 8];
nrt({i,v},'mmmat2set',{f});

%------------------------------------------------------------------------------
%                                      mmset2mat 
%------------------------------------------------------------------------------

coord=int32([[ 0,0];[-1,0];[ 1,1]]);
%>>> A=mmset2mat(coord)
A = ...
[[0 1 0]
 [0 1 0]
 [0 0 1]];
nrt({A},'mmset2mat',{coord});

%>>> print mmdatatype(A)
%>>> binary

vu = uint8([1,2,3]);
%>>> f=mmset2mat((coord,vu))
f = ...
[[0 2 0]
 [0 1 0]
 [0 0 3]];
nrt({f},'mmset2mat',{coord,vu});

%>>> print mmdatatype(f)
%>>> uint8

%>>> vi = int32([1,2,3])
%>>> g=mmset2mat((coord,vi))
%>>> print g
%[[-2147483647           2 -2147483647]
% [-2147483647           1 -2147483647]
% [-2147483647 -2147483647           3]]

%>>> print mmdatatype(g)
%>>> int32

%==================================================================================================
% Image file I/O
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('04:')
%------------------------------------------------------------------------------
%                                     mmreadgray 
%------------------------------------------------------------------------------

%>>> a=mmreadgray('../Data/cookies.tif')
a = nrtReadData('../nrtData/04 - Image file IO/mmreadgray.txt','a');
nrt({a},'mmreadgray',{'../Data/cookies.tif'});
%>>> mmshow(a)

%==================================================================================================
% Relations
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('05:')
%------------------------------------------------------------------------------
%                                          mmcmp 
%------------------------------------------------------------------------------

%>>> mmcmp(uint8([1, 2, 3]),'<', uint8(2))
r = [1 0 0];
nrt({r},'mmcmp',{uint8([1, 2, 3]),'<', uint8(2)});

%>>> mmcmp(uint8([1, 2, 3]),'<', uint8([0, 2, 4]))
r = [0 0 1];
nrt({r},'mmcmp',{uint8([1, 2, 3]),'<', uint8([0, 2, 4])});

%>>> mmcmp(uint8([1, 2, 3]),'==', uint8([1, 1, 3]))
r = [1 0 1];
nrt({r},'mmcmp',{uint8([1, 2, 3]),'==', uint8([1, 1, 3])});

f    = mmreadgray('../Data/keyb.tif');
%>>> fbin = mmcmp(uint8(10), '<', f, '<', uint8(50))
fbin = nrtReadData('../nrtData/05 - Relations/mmcmp.txt','fbin');
nrt({fbin},'mmcmp',{uint8(10), '<', f, '<', uint8(50)});
%>>> mmshow(f)
%>>> mmshow(fbin)

%------------------------------------------------------------------------------
%                                           mmis 
%------------------------------------------------------------------------------

fbin=mmbinary([0, 1]);
f1=uint8([1, 2, 3]);
f2=uint8([2, 2, 3]);
f3=uint8([2, 3, 4]);

%>>> mmis(fbin,'binary')
r = 1.0;
nrt({r},'mmis',{fbin,'binary'});

%>>> mmis(f1,'gray')
r = 1;
nrt({r},'mmis',{f1,'gray'});

%>>> mmis(f1,'==',f2)
r = 0.0;
nrt({r},'mmis',{f1,'==',f2});

%>>> mmis(f1,'<',f3)
r = 1.0;
nrt({r},'mmis',{f1,'<',f3});

%>>> mmis(f1,'<=',f2)
r = 1.0;
nrt({r},'mmis',{f1,'<=',f2});

%>>> mmis(f1,'<=',f2,'<=',f3)
r = 1.0;
nrt({r},'mmis',{f1,'<=',f2,'<=',f3});

%------------------------------------------------------------------------------
%                                     mmisbinary 
%------------------------------------------------------------------------------

a=uint8([0, 1, 0, 1]);
%>>> mmisbinary(a)
r = 0;
nrt({r},'mmisbinary',{a});

b=mmbinary(a);
%>>> mmisbinary(b)
r = 1;
nrt({r},'mmisbinary',{b});

%------------------------------------------------------------------------------
%                                      mmisequal 
%------------------------------------------------------------------------------

f1 = uint8(0:3);
f2 = uint8([9, 5, 3, 3]);
f3 = f1;

%>>> mmisequal(f1,f2)
r = 0.0;
nrt({r},'mmisequal',{f1,f2});

%>>> mmisequal(f1,f3)
r = 1.0;
nrt({r},'mmisequal',{f1,f3});

%------------------------------------------------------------------------------
%                                     mmislesseq 
%------------------------------------------------------------------------------

f1 = uint8([0, 1, 2, 3]);
f2 = uint8([9, 5, 3, 3]);

%>>> mmislesseq(f1,f2)
r = 1.0;
nrt({r},'mmislesseq',{f1,f2});

%>>> mmislesseq(f2,f1)
r = 0.0;
nrt({r},'mmislesseq',{f2,f1});

%>>> mmislesseq(f1,f1)
r = 1.0;
nrt({r},'mmislesseq',{f1,f1});

%==================================================================================================
% Operations
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('06:')
%------------------------------------------------------------------------------
%                                          mmneg 
%------------------------------------------------------------------------------

f=uint8([255, 255, 0, 10, 20, 10, 0, 255, 255]);

%>>> mmneg(f)
r = [  0   0 255 245 235 245 255   0   0];
nrt({r},'mmneg',{f});

%>>> mmneg(uint8([0, 1]))
r = [255 254];
nrt({r},'mmneg',{uint8([0, 1])});

%>>> mmneg(int32([0, 1]))
r = [ 0 -1];
nrt({r},'mmneg',{int32([0, 1])});

a = mmreadgray('../Data/gear.tif');
%>>> b = mmneg(a)
b = nrtReadData('../nrtData/06 - Operations/mmneg.txt','b');
nrt({b},'mmneg',{a});
%>>> mmshow(a)
%>>> mmshow(b)

c = mmreadgray('../Data/astablet.tif');
%>>> d = mmneg(c)
d = nrtReadData('../nrtData/06 - Operations/mmneg.txt','d');
nrt({d},'mmneg',{c});
%>>> mmshow(c)
%>>> mmshow(d)

%------------------------------------------------------------------------------
%                                       mmtoggle 
%------------------------------------------------------------------------------

f  = uint8([0,1,2,3,4,5,6]);
f1 = uint8([0,0,0,0,0,0,0]);
f2 = uint8([6,6,6,6,6,6,6]);

%>>> mmtoggle(f,f1,f2)
r = [0 0 0 6 6 6 6];
nrt({r},'mmtoggle',{f,f1,f2});

a = mmreadgray('../Data/angiogr.tif');
b = mmero(a,mmsedisk(2));
c = mmdil(a,mmsedisk(2));
%>>> d = mmtoggle(a,b,c)
d = nrtReadData('../nrtData/06 - Operations/mmtoggle.txt','d');
nrt({d},'mmtoggle',{a,b,c});
%>>> mmshow(a)
%>>> mmshow(d)

e = mmreadgray('../Data/lenina.tif');
f = mmero(e,mmsedisk(2));
g = mmdil(e,mmsedisk(2));
%>>> h = mmtoggle(e,f,g,'BINARY')
h = nrtReadData('../nrtData/06 - Operations/mmtoggle.txt','h');
nrt({h},'mmtoggle',{e,f,g,'BINARY'});
%>>> mmshow(e)
%>>> mmshow(h)

%------------------------------------------------------------------------------
%                                         mmaddm 
%------------------------------------------------------------------------------

f = uint8([255,   255,    0,   10,    0,   255,   250]);
g = uint8([ 0,    40,   80,   140,  250,    10,    30]);

%>>> y1 = mmaddm(f,g)
y1 = [255 255  80 150 250 255 255];
nrt({y1},'mmaddm',{f,g});

%>>> y2 = mmaddm(g, 100)
y2 = [100 140 180 240 255 110 130];
nrt({y2},'mmaddm',{g, 100});

a = mmreadgray('../Data/keyb.tif');
%>>> b = mmaddm(a,128)
b = nrtReadData('../nrtData/06 - Operations/mmaddm.txt','b');
nrt({b},'mmaddm',{a,128});
%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                     mmintersec 
%------------------------------------------------------------------------------

f=uint8([255,  255,    0,   10,    0,   255,   250]);
g=uint8([ 0,    40,   80,   140,  250,    10,    30]);

%>>> mmintersec(f, g)
r = [ 0 40  0 10  0 10 30];
nrt({r},'mmintersec',{f, g});

%>>> mmintersec(f, 0)
r = [0 0 0 0 0 0 0];
nrt({r},'mmintersec',{f, 0});

a = mmreadgray('../Data/form-ok.tif');
b = mmreadgray('../Data/form-1.tif');
%>>> c = mmintersec(a,b)
c = nrtReadData('../nrtData/06 - Operations/mmintersec.txt','c');
nrt({c},'mmintersec',{a,b});
%>>> mmshow(a)
%>>> mmshow(b)
%>>> mmshow(c)

d = mmreadgray('../Data/tplayer1.tif');
e = mmreadgray('../Data/tplayer2.tif');
f = mmreadgray('../Data/tplayer3.tif');
%>>> g = mmintersec(d,e,f)
g = nrtReadData('../nrtData/06 - Operations/mmintersec.txt','g');
nrt({g},'mmintersec',{d,e,f});
%>>> mmshow(d)
%>>> mmshow(e)
%>>> mmshow(f)
%>>> mmshow(g)

%------------------------------------------------------------------------------
%                                         mmsubm 
%------------------------------------------------------------------------------

f = uint8([255,   255,    0,   10,   20,   10,    0,   255,  255]);
g = uint8([10,     20,   30,   40,   50,   40,   30,    20,    10]);

%>>> mmsubm(f, g)
r = [245 235   0   0   0   0   0 235 245];
nrt({r},'mmsubm',{f, g});

%>>> mmsubm(f, 100)
r = [155 155   0   0   0   0   0 155 155];
nrt({r},'mmsubm',{f, 100});

%>>> mmsubm(100, f)
r = [-155 -155  100   90   80   90  100 -155 -155];          % PYTHON
r = [   0    0  100   90   80   90  100    0    0];          % MATLAB
nrt({r},'mmsubm',{100, f});

a = mmreadgray('../Data/boxdrill-C.tif');
b = mmreadgray('../Data/boxdrill-B.tif');
%>>> c = mmsubm(a,b)
c = nrtReadData('../nrtData/06 - Operations/mmsubm.txt','c');
nrt({c},'mmsubm',{a,b});
%>>> mmshow(a)
%>>> mmshow(b)
%>>> mmshow(c)

%------------------------------------------------------------------------------
%                                       mmsymdif 
%------------------------------------------------------------------------------

a = uint8([1, 2, 3, 4, 5]);
b = uint8([5, 4, 3, 2, 1]);

%>>> mmsymdif(a,b)
r = [4 2 0 2 4];
nrt({r},'mmsymdif',{a,b});

c = mmreadgray('../Data/tplayer1.tif');
d = mmreadgray('../Data/tplayer2.tif');
%>>> e = mmsymdif(c,d)
e = nrtReadData('../nrtData/06 - Operations/mmsymdif.txt','e');
nrt({e},'mmsymdif',{c,d});
%>>> mmshow(c)
%>>> mmshow(d)
%>>> mmshow(e)

%------------------------------------------------------------------------------
%                                        mmunion 
%------------------------------------------------------------------------------

f=uint8([255, 255,  0,  10,   0, 255, 250]);
g=uint8([  0,  40, 80, 140, 250,  10,  30]);

%>>> print mmunion(f, g)
r = [255 255  80 140 250 255 250];
nrt({r},'mmunion',{f, g});

%>>> mmunion(f, 255)
r = [255 255 255 255 255 255 255];
nrt({r},'mmunion',{f, 255});

a = mmreadgray('../Data/form-ok.tif');
b = mmreadgray('../Data/form-1.tif');
%>>> c = mmunion(a,b)
c = nrtReadData('../nrtData/06 - Operations/mmunion.txt','c');
nrt({c},'mmunion',{a,b});
%>>> mmshow(a)
%>>> mmshow(b)
%>>> mmshow(c)

d = mmreadgray('../Data/danaus.tif');
e = mmcmp(d,'<',80);
%>>> f = mmunion(d,mmgray(e))
f = nrtReadData('../nrtData/06 - Operations/mmunion.txt','f');
nrt({f},'mmunion',{d,mmgray(e)});
%>>> mmshow(d)
%>>> mmshow(e)
%>>> mmshow(f)

g = mmreadgray('../Data/tplayer1.tif');
h = mmreadgray('../Data/tplayer2.tif');
i = mmreadgray('../Data/tplayer3.tif');
%>>> j = mmunion(g,h,i)
j = nrtReadData('../nrtData/06 - Operations/mmunion.txt','j');
nrt({j},'mmunion',{g,h,i});
%>>> mmshow(g)
%>>> mmshow(h)
%>>> mmshow(i)
%>>> mmshow(j)

%==================================================================================================
% Structuring Elements
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('07:')
%------------------------------------------------------------------------------
%                                       mmimg2se 
%------------------------------------------------------------------------------

%>>> a = mmimg2se(mmbinary([
%  [0,1,0],
%  [1,1,1],
%  [0,1,0]]))

%>>> print mmseshow(a)

a = ...
[[0 1 0]
 [1 1 1]
 [0 1 0]];
nrt({a},'mmimg2se',{mmbinary([
  [0,1,0],
  [1,1,1],
  [0,1,0]])});

b = mmbinary([
  [0,1,1,1],
  [1,1,1,0]]);

%>>> b1 = mmimg2se(b)
%>>> mmseshow(b1)

b1 = ...
[[0 0 0 0 0]
 [0 0 1 1 1]
 [0 1 1 1 0]];
nrt({b1},'mmimg2se',{b});

c = mmbinary([
  [0,1,0],
  [1,1,1],
  [0,1,0]]);
d = int32([
  [0,0,0],
  [0,1,0],
  [0,0,0]]);
%>>> e = mmimg2se(c,'NON-FLAT',d)
%>>> mmseshow(e)

%e = ...
%[[-2147483647           0 -2147483647]
% [          0           1           0]
% [-2147483647           0 -2147483647]];
%nrt({e},'mmimg2se',{c,'NON-FLAT',d},'not yet');          % TODO int32

%------------------------------------------------------------------------------
%                                        mmsebox 
%------------------------------------------------------------------------------

%>>> b1 = mmsebox()
%>>> mmseshow(b1)
b1 = ...
[[1, 1, 1],
 [1, 1, 1],
 [1, 1, 1]];
nrt({b1},'mmsebox',{});

%>>> b2 = mmsebox(2)
%>>> mmseshow(b2)
b2 = ...
[[1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1]];   
nrt({b2},'mmsebox',{2});

%------------------------------------------------------------------------------
%                                      mmsecross 
%------------------------------------------------------------------------------

%>>> b1 = mmsecross()
%>>> mmseshow(b1)

b1 = ...
[[0 1 0]
 [1 1 1]
 [0 1 0]];
nrt({b1},'mmsecross',{});

%>>> b2 = mmsecross(2)
%>>> mmseshow(b2)

b2 = ...
[[0 0 1 0 0]
 [0 1 1 1 0]
 [1 1 1 1 1]
 [0 1 1 1 0]
 [0 0 1 0 0]];
nrt({b2},'mmsecross',{2});

%------------------------------------------------------------------------------
%                                       mmsedisk 
%------------------------------------------------------------------------------

%>>> a=mmsedisk(10,'CITY-BLOCK')
a = ...
[[0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0]
 [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0]];
nrt({a},'mmsedisk',{10,'CITY-BLOCK'});

%>>> b=mmsedisk(10,'EUCLIDEAN')
b = ...
[[0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0]
 [0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0]];
nrt({b},'mmsedisk',{10,'EUCLIDEAN'});

%>>> c=mmsedisk(10,'OCTAGON')
c = ...
[[0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
 [0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0]
 [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0]];
nrt({c},'mmsedisk',{10,'OCTAGON'});

%>>> d=mmseshow(mmsedisk(10,'2D','CITY-BLOCK','NON-FLAT'))
%>>> e=mmseshow(mmsedisk(10,'2D','EUCLIDEAN','NON-FLAT'))
%>> f=mmseshow(mmsedisk(10,'2D','OCTAGON','NON-FLAT'))
%>>> mmshow(d)
%>>> mmshow(e)
%>>> mmshow(f)

%>>> g=mmsedisk(3,'2D','EUCLIDEAN','NON-FLAT')
%>>> mmseshow(g)
%>>> h=mmsedisk(3,'2D','EUCLIDEAN','NON-FLAT',5)
%>>> mmseshow(h)

%------------------------------------------------------------------------------
%                                       mmseline 
%------------------------------------------------------------------------------

%>>> b0 = mmseline()
b0 = [0, 0, 1, 1, 1];
nrt({b0},'mmseline',{});

%>>> b1 = mmseline(4,45)
%>>> mmseshow(b1)
b1 = ...
[[0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0],
 [0, 0, 1, 0, 0],
 [0, 0, 0, 1, 0],
 [0, 0, 0, 0, 1]];
nrt({b1},'mmseline',{4,45});

%>>> b2 = mmseline(4,-180)
%>>> mmseshow(b2)
b2 = [1, 1, 1, 1, 0, 0, 0];
nrt({b2},'mmseline',{4,-180});

%>>> a=mmtext('Line')         % Pas de mmseline ici !!!
%>>> b=mmdil(a,b1)            % Test inutile
%>>> mmshow(a)
%>>> mmshow(b)
        
%------------------------------------------------------------------------------
%                                        mmserot 
%------------------------------------------------------------------------------

b = mmimg2se(mmbinary([[0, 0, 0], [0, 1, 1], [0, 0, 0]]));
%>>> mmseshow(b)

%>>> r = mmserot(b)
r = ...
[[0, 0, 0],
 [0, 1, 0],
 [0, 0, 1]];
nrt({r},'mmserot',{b});

%>>> r = mmserot(b,45,'ANTI-CLOCKWISE')       
r = ...
[[0, 0, 1],
 [0, 1, 0],
 [0, 0, 0]];
nrt({r},'mmserot',{b,45,'ANTI-CLOCKWISE'});

%------------------------------------------------------------------------------
%                                       mmseshow 
%------------------------------------------------------------------------------

b=mmsecross(3);
%>>> r = mmseshow(b)
r = ...
[[0 0 0 1 0 0 0]
 [0 0 1 1 1 0 0]
 [0 1 1 1 1 1 0]
 [1 1 1 1 1 1 1]
 [0 1 1 1 1 1 0]
 [0 0 1 1 1 0 0]
 [0 0 0 1 0 0 0]];
nrt({r},'mmseshow',{b});

%>>> a = mmseshow(b,'EXPAND')
a = nrtReadData('../nrtData/07 - Structuring Elements/mmseshow.txt','a');
nrt({a},'mmseshow',{b,'EXPAND'});
%>>> mmshow(a)

%------------------------------------------------------------------------------
%                                        mmsesum 
%------------------------------------------------------------------------------

b = mmimg2se(mmbinary([[1, 1, 1]; [1, 1, 1]; [0, 1, 0]]));
%>>> mmseshow(b)

%>>> b3 = mmsesum(b,3)
%>>> mmseshow(b3)
b3 = ...
[[1, 1, 1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1, 1, 1],
 [1, 1, 1, 1, 1, 1, 1],
 [0, 1, 1, 1, 1, 1, 0],
 [0, 0, 1, 1, 1, 0, 0],
 [0, 0, 0, 1, 0, 0, 0]];
nrt({b3},'mmsesum',{b,3});

%>>> b = mmsedisk(1,'2D','CITY-BLOCK','NON-FLAT');
%>>> mmseshow(b)
%>>> mmseshow(mmsesum(b,2))

%------------------------------------------------------------------------------
%                                      mmsetrans 
%------------------------------------------------------------------------------

b1 = mmseline(5);
%>>> mmseshow(b1)

%>>> b2 = mmsetrans(b1,[2,-2])
%>>> mmseshow(b2)
b2 = ...
[[0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0],
 [1, 1, 1, 1, 1]];
nrt({b2},'mmsetrans',{b1,[2,-2]});

%------------------------------------------------------------------------------
%                                    mmsereflect 
%------------------------------------------------------------------------------

b1 = mmseline(5,30);
%>>> print mmseshow(b1)
%>>> b2 = mmsereflect(b1)
%>>> print mmseshow(b2)
b2 = ...
[[1 0 0 0 0 0 0]
 [0 1 1 0 0 0 0]
 [0 0 0 1 0 0 0]
 [0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0]];
nrt({b2},'mmsereflect',{b1});

%------------------------------------------------------------------------------
%                                        mmsedil 
%------------------------------------------------------------------------------

b1 = mmseline(5);
%>>> mmseshow(b1)
b2 = mmsedisk(2);
%>>> mmseshow(b2)

%>>> b3 = mmsedil(b1,b2)
%>>> mmseshow(b3)
        
b3 = ...
[[0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0],
 [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
 [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
 [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
 [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0]];
nrt({b3},'mmsedil',{b1,b2});

%------------------------------------------------------------------------------
%                                      mmseunion 
%------------------------------------------------------------------------------

b1 = mmseline(5);
%>>> mmseshow(b1)
b2 = mmsedisk(3);
%>>> mmseshow(b2)

%>>> b3 = mmseunion(b1,b2)
%>>> mmseshow(b3)
        
b3 = ...
[[0, 0, 0, 1, 1, 1, 0, 0, 0],
 [0, 0, 1, 1, 1, 1, 1, 0, 0],
 [0, 1, 1, 1, 1, 1, 1, 1, 0],
 [0, 1, 1, 1, 1, 1, 1, 1, 1],
 [0, 1, 1, 1, 1, 1, 1, 1, 0],
 [0, 0, 1, 1, 1, 1, 1, 0, 0],
 [0, 0, 0, 1, 1, 1, 0, 0, 0]];
nrt({b3},'mmseunion',{b1,b2});


%==================================================================================================
% Dilations And Erosions
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('08:')
%------------------------------------------------------------------------------
%                                         mmcdil 
%------------------------------------------------------------------------------

f = mmbinary(uint8(
   [[1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 0,]]));
g = mmbinary(uint8(
   [[1, 1, 1, 0, 0, 1, 1],
    [1, 0, 1, 1, 1, 0, 0],
    [0, 0, 0, 0, 1, 0, 0]]));

%>> y1=mmcdil(f,g,mmsecross())
y1 = [
   1   1   0   0   0   0   0
   1   0   0   0   1   0   0
   0   0   0   0   1   0   0];
nrt({y1},'mmcdil',{f,g,mmsecross()});                     % A VERIFIER TOUT MMCDIL

%>>> y2=mmcdil(f,g,mmsecross(),3)
y2 = [
   1   1   1   0   0   0   0
   1   0   1   1   1   0   0
   0   0   0   0   1   0   0];
nrt({y2},'mmcdil',{f,g,mmsecross(),3});

f = uint8([
    [   0,    0,   0,   80,   0,   0],
    [   0,    0,   0,    0,   0,   0],
    [  10,   10,   0,  255,   0,   0]]);

g = uint8([
    [   0,    1,   2,   50,   4,   5],
    [   2,    3,   4,    0,   0,   0],
    [  12,  255,  14,   15,  16,  17]]);

%>>> y1=mmcdil(f,g,mmsecross())
y1 = [
   0   0   2  50   4   0
   2   3   0   0   0   0
  10  10  14  15  15   0];
nrt({y1},'mmcdil',{f,g,mmsecross()});

%>>> y2=mmcdil(f,g,mmsecross(),3)
y2 = [
   0   1   2  50   4   4
   2   3   4   0   0   0
  12  14  14  15  15  15];
nrt({y2},'mmcdil',{f,g,mmsecross(),3});     


g=mmreadgray('../Data/pcb1bin.tif');
f=mmframe(g,5,5);

%>>> y5=mmcdil(f,g,mmsecross(),5)
y5 = nrtReadData('../nrtData/08 - Dilations And Erosions/mmcdil.txt','y5');
nrt({y5},'mmcdil',{f,g,mmsecross(),5});

%>>> y25=mmcdil(f,g,mmsecross(),25)
y25 = nrtReadData('../nrtData/08 - Dilations And Erosions/mmcdil.txt','y25');
nrt({y25},'mmcdil',{f,g,mmsecross(),25});

%>>> mmshow(g)
%>>> mmshow(g,f)
%>>> mmshow(g,y5)
%>>> mmshow(g,y25)


g=mmneg(mmreadgray('../Data/n2538.tif'));
f=mmintersec(g,0);
%%%f=mmdraw (f,'LINE:40,30,60,30:END');     % Ancienne Version Python
%%%f=mmdrawv(f,[[30,30];
%%%             [40,60]],255,'line');       % Nouvelle Version Python
f=mmdrawv(f,[[41,31]; ...
             [61,31]],255,'line');          % Nouvelle Version Matlab

%>>> y1=mmcdil(f,g,mmsebox())
y1 = nrtReadData('../nrtData/08 - Dilations And Erosions/mmcdil.txt','y1');
nrt({y1},'mmcdil',{f,g,mmsebox()});

%>>> y30=mmcdil(f,g,mmsebox(),30)
y30 = nrtReadData('../nrtData/08 - Dilations And Erosions/mmcdil.txt','y30');
nrt({y30},'mmcdil',{f,g,mmsebox(),30});

%>>> mmshow(g)
%>>> mmshow(f)
%>>> mmshow(y1)
%>>> mmshow(y30)
        
%------------------------------------------------------------------------------
%                                         mmcero 
%------------------------------------------------------------------------------

f = mmneg(mmtext('hello'));              % La version PYTHON ne marche pas
g = mmdil(f,mmseline(7,90));

%>>> a1=mmcero(g,f,mmsebox())
a1 = nrtReadData('../nrtData/08 - Dilations And Erosions/mmcero.txt','a1');
nrt({a1},'mmcero',{g,f,mmsebox()});

%>>> a13=mmcero(a1,f,mmsebox(),13)
a13 = nrtReadData('../nrtData/08 - Dilations And Erosions/mmcero.txt','a13');
nrt({a13},'mmcero',{a1,f,mmsebox(),13});

%>>> mmshow(f)
%>>> mmshow(g)
%>>> mmshow(a1)
%>>> mmshow(a13)

%------------------------------------------------------------------------------
%                                          mmdil 
%------------------------------------------------------------------------------

f=mmbinary([
   [0, 0, 0, 0, 0, 0, 1],
   [0, 1, 0, 0, 0, 0, 0],
   [0, 0, 0, 0, 1, 0, 0]]);
b=mmbinary([1, 1, 0]);

%>>> mmdil(f,b)
r = [[0, 0, 0, 0, 0, 1, 1],
     [1, 1, 0, 0, 0, 0, 0],
     [0, 0, 0, 1, 1, 0, 0]];
nrt({r},'mmdil',{f,b});

f=uint8([
   [ 0,   1,  2, 50,  4,  5],
   [ 2,   3,  4,  0,  0,  0],
   [12, 255, 14, 15, 16, 17]]);

%>>> mmdil(f,b)
r = [[  1,   2,  50,  50,   5,   5],
     [  3,   4,   4,   0,   0,   0],
     [255, 255,  15,  16,  17,  17]];
nrt({r},'mmdil',{f,b});


f   =mmbinary(mmreadgray('../Data/blob.tif'));
bimg=mmbinary(mmreadgray('../Data/blob1.tif'));
b   =mmimg2se(bimg);

%>>> r = mmdil(f,b)
r = nrtReadData('../nrtData/08 - Dilations And Erosions/mmdil.txt','r');
nrt({r},'mmdil',{f,b});

%>>> mmshow(f)
%>>> mmshow(mmdil(f,b))
%>>> mmshow(mmdil(f,b),mmgradm(f))


f=mmreadgray('../Data/pcb_gray.tif');
b=mmsedisk(5);

%>>> r = mmdil(f,b)
r = nrtReadData('../nrtData/08 - Dilations And Erosions/mmdil.txt','r',2);
nrt({r},'mmdil',{f,b});

%>>> mmshow(f)
%>>> mmshow(mmdil(f,b))

%------------------------------------------------------------------------------
%                                          mmero 
%------------------------------------------------------------------------------

f=mmbinary([
   [1, 1, 1, 0, 0, 1, 1],
   [1, 0, 1, 1, 1, 0, 0],
   [0, 0, 0, 0, 1, 0, 0]]);
b=mmbinary([1, 1, 0]);

%>>> mmero(f,b)
r = [[1, 1, 1, 0, 0, 0, 1],
     [1, 0, 0, 1, 1, 0, 0],
     [0, 0, 0, 0, 0, 0, 0]];
nrt({r},'mmero',{f,b});

f=uint8([
   [ 0,   1,  2, 50,  4,  5],
   [ 2,   3,  4,  0,  0,  0],
   [12, 255, 14, 15, 16, 17]]);

%>>> mmero(f,b)
r = [[ 0,  0,  1,  2,  4,  4],
     [ 2,  2,  3,  0,  0,  0],
     [12, 12, 14, 14, 15, 16]];
nrt({r},'mmero',{f,b});

f    = mmbinary(mmreadgray('../Data/blob.tif'));
bimg = mmbinary(mmreadgray('../Data/blob1.tif'));
b    = mmimg2se(bimg);
%>>> g=mmero(f,b)
g = nrtReadData('../nrtData/08 - Dilations And Erosions/mmero.txt','g');
nrt({g},'mmero',{f,b});

%>>> mmshow(f)
%>>> mmshow(g)
%>>> mmshow(g,mmgradm(f))


f=mmreadgray('../Data/pcb_gray.tif');
b=mmsedisk(3);

%>>> r = mmero(f,b)
r = nrtReadData('../nrtData/08 - Dilations And Erosions/mmero.txt','r');
nrt({r},'mmero',{f,b});

%>>> mmshow(f)
%>>> mmshow(mmero(f,b))

%==================================================================================================
% Morphological Filters
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('09:')
%------------------------------------------------------------------------------
%                                       mmcenter 
%------------------------------------------------------------------------------

f=mmreadgray('../Data/gear.tif');
%>>> g=mmcenter(f,mmsedisk(2))
g = nrtReadData('../nrtData/09 - Morphological Filters/mmcenter.txt','g');
nrt({g},'mmcenter',{f,mmsedisk(2)});
%>>> mmshow(f)
%>>> mmshow(g)

%------------------------------------------------------------------------------
%                                          mmasf 
%------------------------------------------------------------------------------

f=mmreadgray('../Data/gear.tif');
%>>> g=mmasf(f,'oc',mmsecross(),2)
g = nrtReadData('../nrtData/09 - Morphological Filters/mmasf.txt','g');
nrt({g},'mmasf',{f,'oc',mmsecross(),2});
%>>> mmshow(f)
%>>> mmshow(g)

f=mmreadgray('../Data/fabric.tif');
%>>> g=mmasf(f,'oc',mmsecross(),3)
g = nrtReadData('../nrtData/09 - Morphological Filters/mmasf.txt','g',2);
nrt({g},'mmasf',{f,'oc',mmsecross(),3});
%>>> mmshow(f)
%>>> mmshow(g)

%------------------------------------------------------------------------------
%                                        mmclose 
%------------------------------------------------------------------------------

f   =mmreadgray('../Data/blob.tif');
bimg=mmreadgray('../Data/blob1.tif');
b   =mmimg2se(bimg);

% r = mmclose(f,b)
r = nrtReadData('../nrtData/09 - Morphological Filters/mmclose.txt','r');
nrt({r},'mmclose',{f,b});

%>>> mmshow(f)
%>>> mmshow(mmclose(f,b))
%>>> mmshow(mmclose(f,b),mmgradm(f))


f = mmreadgray('../Data/form-1.tif');

%>>> y = mmclose(f,mmsedisk(4))
y = nrtReadData('../nrtData/09 - Morphological Filters/mmclose.txt','y');
nrt({y},'mmclose',{f,mmsedisk(4)});

%>>> mmshow(f)
%>>> mmshow(y)


f = mmreadgray('../Data/n2538.tif');

%>>> y = mmclose(f,mmsedisk(3))
y = nrtReadData('../nrtData/09 - Morphological Filters/mmclose.txt','y',2);
nrt({y},'mmclose',{f,mmsedisk(3)});

%>>> mmshow(f)
%>>> mmshow(y)

%------------------------------------------------------------------------------
%                                         mmopen 
%------------------------------------------------------------------------------

f   =mmbinary(mmreadgray('../Data/blob.tif'));
bimg=mmbinary(mmreadgray('../Data/blob1.tif'));
b   =mmimg2se(bimg);

% r = mmopen(f,b)
r = nrtReadData('../nrtData/09 - Morphological Filters/mmopen.txt','r');
nrt({r},'mmopen',{f,b});

%>>> mmshow(f)
%>>> mmshow(mmopen(f,b))
%>>> mmshow(mmopen(f,b),mmgradm(f))
        
a=mmbinary(mmreadgray('../Data/pcb1bin.tif'));

%>>> b=mmopen(a,mmsebox(2))
b = nrtReadData('../nrtData/09 - Morphological Filters/mmopen.txt','b',2);
nrt({b},'mmopen',{a,mmsebox(2)});

%>>> c=mmopen(a,mmsebox(4))
c = nrtReadData('../nrtData/09 - Morphological Filters/mmopen.txt','c');
nrt({c},'mmopen',{a,mmsebox(4)});

%>>> mmshow(a)
%>>> mmshow(b)
%>>> mmshow(c)
        

a=mmreadgray('../Data/astablet.tif');

%>>> b=mmopen(a,mmsedisk(18))
b = nrtReadData('../nrtData/09 - Morphological Filters/mmopen.txt','b',3);
nrt({b},'mmopen',{a,mmsedisk(18)});

%>>> mmshow(a)
%>>> mmshow(b)

%==================================================================================================
% Image Transforms
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('10:')
%------------------------------------------------------------------------------
%                                         mmdist 
%------------------------------------------------------------------------------

% TODO

f = mmreadgray('../Data/gear.tif');
f = mmneg(mmgradm(f));

%>>> d4=mmdist(f)
d4 = nrtReadData('../nrtData/10 - Image Transforms/mmdist.txt','d4');      % PB
nrt({d4},'mmdist',{f},'not yet');

%>>> d8=mmdist(f,mmsebox())
d8 = nrtReadData('../nrtData/10 - Image Transforms/mmdist.txt','d8');      % PB
nrt({d8},'mmdist',{f,mmsebox()},'not yet');

%>>> de=mmdist(f,mmsebox(),'EUCLIDEAN')
de = nrtReadData('../nrtData/10 - Image Transforms/mmdist.txt','de');      % PB
nrt({de},'mmdist',{f,mmsebox(),'EUCLIDEAN'},'not yet');

%>>> mmshow(f)
%>>> mmshow(d4%8)
%>>> mmshow(d8%8)
%>>> mmshow(de%8)

%------------------------------------------------------------------------------
%                                        mmgdist 
%------------------------------------------------------------------------------

f=mmbinary([
 [1,1,1,1,1,1],
 [1,1,1,0,0,1],
 [1,0,1,0,0,1],
 [1,0,1,1,0,0],
 [0,0,1,1,1,1],
 [0,0,0,1,1,1]]);

g=mmbinary([
 [0,0,0,0,0,0],
 [1,1,0,0,0,0],
 [0,0,0,0,0,0],
 [0,0,0,0,0,0],
 [0,0,0,0,0,0],
 [0,0,0,0,0,1]]);

%>>> y=mmgdist(f,g,mmsecross())

y = ...
[[    1     1     2     3     4     5]
 [    0     0     1 65535 65535     6]
 [    1 65535     2 65535 65535     7]
 [    2 65535     3     4 65535 65535]
 [65535 65535     4     3     2     1]
 [65535 65535 65535     2     1     0]];
nrt({y},'mmgdist',{f,g,mmsecross()});

%%% NOT IMPLEMENTED IN PYTHON

%------------------------------------------------------------------------------
%                                   mmopentransf 
%------------------------------------------------------------------------------

f = mmbinary([
              [0,0,0,0,0,0,0,0],
              [0,0,1,1,1,1,0,0],
              [0,0,1,1,1,1,1,0],
              [0,1,0,1,1,1,0,0],
              [1,1,0,0,0,0,0,0]]);

%>>> print mmopentransf( f, 'city-block')
r = ...
[[0 0 0 0 0 0 0 0]
 [0 0 1 2 2 2 0 0]
 [0 0 2 2 2 2 2 0]
 [0 1 0 2 2 2 0 0]
 [1 1 0 0 0 0 0 0]];
nrt({r},'mmopentransf',{f, 'city-block'});

%>>> print mmopentransf( f, 'linear-h')
r = ...
[[0 0 0 0 0 0 0 0]
 [0 0 2 2 2 2 0 0]
 [0 0 3 3 3 3 3 0]
 [0 1 0 2 2 2 0 0]
 [2 2 0 0 0 0 0 0]];
nrt({r},'mmopentransf',{f, 'linear-h'});

%>>> print mmopentransf( f, 'linear-45r')
r = ...
[[0 0 0 0 0 0 0 0]
 [0 0 1 4 1 2 0 0]
 [0 0 4 1 2 1 1 0]
 [0 4 0 2 1 1 0 0]
 [4 1 0 0 0 0 0 0]];
nrt({r},'mmopentransf',{f, 'linear-45r'});

%>>> print mmopentransf( f, 'user',10,mmsecross(),mmbinary([0,1,1]))
r = ...
[[0 0 0 0 0 0 0 0]
 [0 0 4 4 4 4 0 0]
 [0 0 5 5 5 5 5 0]
 [0 1 0 3 3 3 0 0]
 [2 2 0 0 0 0 0 0]];
nrt({r},'mmopentransf',{f, 'user',10,mmsecross(),mmbinary([0,1,1])});

%>>> print mmopentransf( f, 'city-block-rec')
r = ...
[[0 0 0 0 0 0 0 0]
 [0 0 2 2 2 2 0 0]
 [0 0 2 2 2 2 2 0]
 [0 1 0 2 2 2 0 0]
 [1 1 0 0 0 0 0 0]];
nrt({r},'mmopentransf',{f, 'city-block-rec'});

f=mmreadgray('../Data/numbers.tif');
%>>> g=mmopentransf(f,'OCTAGON')
g = nrtReadData('../nrtData/10 - Image Transforms/mmopentransf.txt','g');
nrt({g},'mmopentransf',{f,'OCTAGON'});

%>>> mmshow(f)
%>>> mmshow(g)

% AUTRE PROGRAMME : NON APPROPRIE

%==================================================================================================
% Connected Operators
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('11:')
%------------------------------------------------------------------------------
%                                      mmclohole 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/pcb1bin.tif');
%>>> b = mmclohole(a)
b = nrtReadData('../nrtData/11 - Connected Operators/mmclohole.txt','b');
nrt({b},'mmclohole',{a});
%>>> mmshow(a)
%>>> mmshow(b)

a = mmreadgray('../Data/boxdrill-B.tif');
%>>> b = mmclohole(a)
b = nrtReadData('../nrtData/11 - Connected Operators/mmclohole.txt','b',2);
nrt({b},'mmclohole',{a});
%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                    mmareaclose 
%------------------------------------------------------------------------------

%a=mmreadgray('../Data/form-1.tif');                    % TROP LONG
%>>> b=mmareaclose(a,400)
%b = nrtReadData('../nrtData/11 - Connected Operators/mmareaclose.txt','b');
%nrt({b},'mmareaclose',{a,400});
%>>> mmshow(a)
%>>> mmshow(b)


%a=mmreadgray('../Data/n2538.tif');                     % TROP LONG
%>>> b=mmareaclose(a,400)
%b = nrtReadData('../nrtData/11 - Connected Operators/mmareaclose.txt','b',2);
%nrt({b},'mmareaclose',{a,400});
%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                     mmareaopen 
%------------------------------------------------------------------------------

f=mmbinary(uint8([
 [1, 1, 0, 0, 0, 0, 1],
 [1, 0, 1, 1, 1, 0, 1],
 [0, 0, 0, 0, 1, 0, 0]]));

%>>> y=mmareaopen(f,4,mmsecross())
y = ...
[[0 0 0 0 0 0 0]
 [0 0 1 1 1 0 0]
 [0 0 0 0 1 0 0]];
nrt({y},'mmareaopen',{f,4,mmsecross()});

f=uint8([
   [10,   11,   0,    0,   0,   0,  20],
   [10,    0,   5,    8,   9,   0,  15],
   [10,    0,   0,    0,  10,   0,   0]]);

%>>> y=mmareaopen(f,4,mmsecross())
y = ...
[[10 10  0  0  0  0  0]
 [10  0  5  5  5  0  0]
 [10  0  0  0  5  0  0]];
nrt({y},'mmareaopen',{f,4,mmsecross()});

%a=mmreadgray('../Data/form-1.tif');                   % TROP LONG
%>>> b=mmareaopen(a,500);
%b = nrtReadData('../nrtData/11 - Connected Operators/mmareaopen.txt','b');
%nrt({b},'mmareaopen',{a,500});
%>>> mmshow(a);
%>>> mmshow(b);

%a=mmreadgray('../Data/bloodcells.tif');               % TROP LONG
%>>> b=mmareaopen(a,500);
%b = nrtReadData('../nrtData/11 - Connected Operators/mmareaopen.txt','b',2);
%nrt({b},'mmareaopen',{a,500});
%>>> mmshow(a);
%>>> mmshow(b);

%------------------------------------------------------------------------------
%                                       mmasfrec 
%------------------------------------------------------------------------------

f=mmreadgray('../Data/fabric.tif');
%>>> g=mmasfrec(f,'oc',mmsecross(),mmsecross(),3)
g = nrtReadData('../nrtData/11 - Connected Operators/mmasfrec.txt','g');
nrt({g},'mmasfrec',{f,'oc',mmsecross(),mmsecross(),3});
%>>> mmshow(f)
%>>> mmshow(g)

%------------------------------------------------------------------------------
%                                     mmcloserec 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/danaus.tif');
%>>> b = mmcloserec(a,mmsebox(4))
b = nrtReadData('../nrtData/11 - Connected Operators/mmcloserec.txt','b');
nrt({b},'mmcloserec',{a,mmsebox(4)});
%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                         mmhmin 
%------------------------------------------------------------------------------

a = uint8([
    [10,   3,   6,  18,  16,  15,  10],
    [10,   9,   6,  18,   6,   5,  10],
    [10,   9,   9,  15,   4,   9,  10],
    [10,  10,  10,  10,  10,  10,  10]]);

%>>> print mmhmin(a,1,mmsebox())
r = ...
[[10  4  6 18 16 15 10]
 [10  9  6 18  6  5 10]
 [10  9  9 15  5  9 10]
 [10 10 10 10 10 10 10]];
nrt({r},'mmhmin',{a,1,mmsebox()});

f = mmreadgray('../Data/r4x2_256.tif');
%>>> fb = mmhmin(f,70)
fb = nrtReadData('../nrtData/11 - Connected Operators/mmhmin.txt','fb');
nrt({fb},'mmhmin',{f,70});
%>>> mmshow(f)
%>>> mmshow(fb)
%>>> mmshow(mmregmin(fb))

%------------------------------------------------------------------------------
%                                         mmvmax 
%------------------------------------------------------------------------------

%%% Not implemented yet

%------------------------------------------------------------------------------
%                                         mmhmax 
%------------------------------------------------------------------------------

a = uint8([
    [4,   3,   6,  1,  3,  5,  2],
    [2,   9,   6,  1,  6,  7,  3],
    [8,   9,   3,  2,  4,  9,  4],
    [3,   1,   2,  1,  2,  4,  2]]);

% >>> print mmhmax(a,2,mmsebox())
r = ...
[[4 3 6 1 3 5 2]
 [2 7 6 1 6 7 3]
 [7 7 3 2 4 7 4]
 [3 1 2 1 2 4 2]];
nrt({r},'mmhmax',{a,2,mmsebox()});

f  = mmreadgray('../Data/r4x2_256.tif');

%>>> fb = mmhmax(f,50);
fb = nrtReadData('../nrtData/11 - Connected Operators/mmhmax.txt','fb');
nrt({fb},'mmhmax',{f,50});

%>>> g  = mmregmax(fb);
g = nrtReadData('../nrtData/11 - Connected Operators/mmhmax.txt','g');
nrt({g},'mmregmax',{fb});

%>>> mmshow(f)
%>>> mmshow(fb)
%>>> mmshow(g)

%------------------------------------------------------------------------------
%                                       mminfrec 
%------------------------------------------------------------------------------

g=mmreadgray('../Data/text_128.tif');
f=mmero(g,mmseline(9,90));

%>>> y=mminfrec(f,g,mmsebox())
y = nrtReadData('../nrtData/11 - Connected Operators/mminfrec.txt','y');
nrt({y},'mminfrec',{f,g,mmsebox()});

%>>> mmshow(g)
%>>> mmshow(f)
%>>> mmshow(y)

% TODO

%------------------------------------------------------------------------------
%                                        mminpos 
%------------------------------------------------------------------------------

% PAS D'EXEMPLE

%------------------------------------------------------------------------------
%                                      mmopenrec 
%------------------------------------------------------------------------------

% PAS D'EXEMPLE

%------------------------------------------------------------------------------
%                                       mmregmax 
%------------------------------------------------------------------------------

% PAS D'EXEMPLE

%------------------------------------------------------------------------------
%                                       mmregmin 
%------------------------------------------------------------------------------

a = uint8([
    [10,  10,  10,  10,  10,  10,  10],
    [10,   9,   6,  18,   6,   5,  10],
    [10,   9,   6,  18,   6,   5,  10],
    [10,   9,   9,  15,   4,   9,  10],
    [10,   9,   9,  15,  12,  10,  10],
    [10,  10,  10,  10,  10,  10,  10]]);

%>>> print mmregmin(a)
r = ...
[[0 0 0 0 0 0 0]
 [0 0 1 0 0 1 0]
 [0 0 1 0 0 1 0]
 [0 0 0 0 1 0 0]
 [0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0]];
nrt({r},'mmregmin',{a});

%>>> print mmregmin(a,mmsecross(),'value')         % PYTHON NOT IMPLEMENTED
%r = ...
%[[0 0 0 0 0 0 0]
% [0 0 6 0 0 5 0]
% [0 0 6 0 0 5 0]
% [0 0 0 0 4 0 0]
% [0 0 0 0 0 0 0]
% [0 0 0 0 0 0 0]];
%nrt({r},'mmregmin',{a,mmsecross(),'value'},'not yet');

%>>> print mmregmin(a,mmsecross(),'dynamics')      % PYTHON NOT IMPLEMENTED
%r = ...
%[[ 0  0  0  0  0  0  0]
% [ 0  0  4  0  0  1  0]
% [ 0  0  4  0  0  1  0]
% [ 0  0  0  0 14  0  0]
% [ 0  0  0  0  0  0  0]
% [ 0  0  0  0  0  0  0]];
%nrt({r},'mmregmin',{a,mmsecross(),'dynamics'},'not yet');

f1=mmreadgray('../Data/bloodcells.tif');

%>>> m1=mmregmin(f1,mmsebox())
m1 = nrtReadData('../nrtData/11 - Connected Operators/mmregmin.txt','m1');
nrt({m1},'mmregmin',{f1,mmsebox()});

f2=mmhmin(f1,70);

%>>> m2=mmregmin(f2,mmsebox())
m2 = nrtReadData('../nrtData/11 - Connected Operators/mmregmin.txt','m2');
nrt({m2},'mmregmin',{f2,mmsebox()});

%>>> mmshow(f1,m1)
%>>> mmshow(f2)
%>>> mmshow(f2,m2)

% TODO

%------------------------------------------------------------------------------
%                                       mmsuprec 
%------------------------------------------------------------------------------

% PAS D'EXEMPLE

%==================================================================================================
% Residues
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('12:')
%------------------------------------------------------------------------------
%                                      mmedgeoff 
%------------------------------------------------------------------------------

a=mmreadgray('../Data/form-1.tif');
%>>> b=mmedgeoff(a)
b = nrtReadData('../nrtData/12 - Residues/mmedgeoff.txt','b');
nrt({b},'mmedgeoff',{a});

%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                    mmcbisector 
%------------------------------------------------------------------------------

a=mmreadgray('../Data/blob2.tif');

%>>> b=mmcbisector(a,mmsebox(),1)
b = nrtReadData('../nrtData/12 - Residues/mmcbisector.txt','b');
nrt({b},'mmcbisector',{a,mmsebox(),1});

%>>> c=mmcbisector(a,mmsebox(),3)
c = nrtReadData('../nrtData/12 - Residues/mmcbisector.txt','c');
nrt({c},'mmcbisector',{a,mmsebox(),3});

%>>> d=mmcbisector(a,mmsebox(),10)
d = nrtReadData('../nrtData/12 - Residues/mmcbisector.txt','d');
nrt({d},'mmcbisector',{a,mmsebox(),10});

%>>> mmshow(a,b)
%>>> mmshow(a,c)
%>>> mmshow(a,d)

%------------------------------------------------------------------------------
%                                   mmcloserecth 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/danaus.tif');

%>>> b = mmcloserecth(a,mmsebox(4))
b = nrtReadData('../nrtData/12 - Residues/mmcloserecth.txt','b');
nrt({b},'mmcloserecth',{a,mmsebox(4)});

%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                      mmcloseth 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/danaus.tif');

%>>> b = mmcloseth(a,mmsebox(5))
b = nrtReadData('../nrtData/12 - Residues/mmcloseth.txt','b');
nrt({b},'mmcloseth',{a,mmsebox(5)});

%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                        mmgradm 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/small_bw.tif');

%>>> b = mmgradm(a)
b = ...
[[0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0]
 [0 0 0 0 0 1 1 0 0 1 1 0 0 0 0 0]
 [0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0]
 [0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0]
 [0 0 1 1 0 0 0 0 0 0 0 0 1 1 0 0]
 [0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0]
 [1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1]
 [1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1]
 [1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 1]
 [0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0]
 [0 0 1 1 1 1 1 0 0 1 1 1 1 1 0 0]
 [0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0]
 [0 0 0 0 0 1 1 0 0 1 1 0 0 0 0 0]
 [0 0 0 0 1 1 1 1 1 1 1 1 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0]];
nrt({b},'mmgradm',{a});

%>>> mmshow(a)
%>>> mmshow(b)

%>>> c=mmgradm(a,mmsecross(0),mmsecross())
c = ...
[[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0]
 [0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0]
 [0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0]
 [0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0]
 [0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0]
 [0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0]
 [0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0]
 [0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0]
 [0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0]
 [0 0 0 1 1 1 1 0 0 1 1 1 1 0 0 0]
 [0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]];
nrt({c},'mmgradm',{a,mmsecross(0),mmsecross()});

%>>> d=mmgradm(a,mmsecross(),mmsecross(0))
d = ...
[[0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0]
 [0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0]
 [0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0]
 [0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0]
 [0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0]
 [0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0]
 [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
 [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
 [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1]
 [0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0]
 [0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0]
 [0 0 0 1 1 1 1 0 0 1 1 1 1 0 0 0]
 [0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0]
 [0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0]
 [0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0]];
nrt({d},'mmgradm',{a,mmsecross(),mmsecross(0)});

%>>> mmshow(a,c)
%>>> mmshow(a,d)

a = mmreadgray('../Data/bloodcells.tif');

%>>> b = mmgradm(a)
b = nrtReadData('../nrtData/12 - Residues/mmgradm.txt','b',2);
nrt({b},'mmgradm',{a});

%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                    mmopenrecth 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                       mmopenth 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/keyb.tif');

%>>> b = mmopenth(a,mmsebox(3))
b = nrtReadData('../nrtData/12 - Residues/mmopenth.txt','b');
nrt({b},'mmopenth',{a,mmsebox(3)});

%>>> mmshow(a)
%>>> mmshow(b)

%------------------------------------------------------------------------------
%                                        mmskelm 
%------------------------------------------------------------------------------

a = mmneg(mmframe(mmbinary(ones(7,9))));

%>>> print mmskelm(a)
r = ...
[[0 0 0 0 0 0 0 0 0]
 [0 1 0 0 0 0 0 1 0]
 [0 0 1 0 0 0 1 0 0]
 [0 0 0 1 1 1 0 0 0]
 [0 0 1 0 0 0 1 0 0]
 [0 1 0 0 0 0 0 1 0]
 [0 0 0 0 0 0 0 0 0]];
nrt({r},'mmskelm',{a});

%>>> print mmskelm(a,mmsebox())
r = ...
[[0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0]
 [0 0 0 1 1 1 0 0 0]
 [0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0]
 [0 0 0 0 0 0 0 0 0]];
nrt({r},'mmskelm',{a,mmsebox()});

a=mmreadgray('../Data/pcbholes.tif');
%>>> b=mmskelm(a)
b = nrtReadData('../nrtData/12 - Residues/mmskelm.txt','b');
nrt({b},'mmskelm',{a});

%>>> mmshow(a)
%>>> mmshow(b)

%>>> c=mmskelm(a,mmsecross(),'value')
c = nrtReadData('../nrtData/12 - Residues/mmskelm.txt','c');
nrt({c},'mmskelm',{a,mmsecross(),'value'});

%>>> mmshow(c)

%------------------------------------------------------------------------------
%                                     mmskelmrec 
%------------------------------------------------------------------------------

a = mmneg(mmframe(mmbinary(ones(7,9))));

%>>> b=mmskelm(a,mmsecross(),'value')
b = ...
[[0 0 0 0 0 0 0 0 0]
 [0 1 0 0 0 0 0 1 0]
 [0 0 2 0 0 0 2 0 0]
 [0 0 0 3 3 3 0 0 0]
 [0 0 2 0 0 0 2 0 0]
 [0 1 0 0 0 0 0 1 0]
 [0 0 0 0 0 0 0 0 0]];
nrt({b},'mmskelm',{a,mmsecross(),'value'});

%>>> c=mmskelmrec(b,mmsecross())
c = ...
[[0 0 0 0 0 0 0 0 0]
 [0 1 1 1 1 1 1 1 0]
 [0 1 1 1 1 1 1 1 0]
 [0 1 1 1 1 1 1 1 0]
 [0 1 1 1 1 1 1 1 0]
 [0 1 1 1 1 1 1 1 0]
 [0 0 0 0 0 0 0 0 0]];
nrt({c},'mmskelmrec',{b,mmsecross()});

%==================================================================================================
% Intervals (hit-or-miss templates)
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('13:')
%------------------------------------------------------------------------------
%                                    mmendpoints 
%------------------------------------------------------------------------------

%>>> print mmintershow(mmendpoints())
% FORME PAS POSSIBLE A CAUSE D'UN BUG D'OCTAVE
%r = {
%    [0   0   0
%    0   1   0
%     0   0   0],
%    [0   0   0
%     1   0   1
%     1   1   1]
%};
r = {[0 0 0;0 1 0;0 0 0],[0 0 0;1 0 1;1 1 1]};
nrt({r},'mmendpoints',{});

%>>> print mmintershow(mmendpoints('HOMOTOPIC'))
r = {[0 1 0;0 1 0;0 0 0],[0 0 0;1 0 1;1 1 1]};
nrt({r},'mmendpoints',{'HOMOTOPIC'});

% TODO

%------------------------------------------------------------------------------
%                                    mmhomothick 
%------------------------------------------------------------------------------

%>>> print mmintershow(mmhomothick())
r = {[1 1 1;0 0 0;0 0 0],[0 0 0;0 1 0;1 1 1]};
nrt({r},'mmhomothick',{});

%------------------------------------------------------------------------------
%                                     mmhomothin 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                      mminterot 
%------------------------------------------------------------------------------

b1 = mmendpoints();

%>>> b2 = mminterot(b1)
b2 = {1,[1 0 0;1 0 0;1 1 1]};
nrt({b2},'mminterot',{b1});

%------------------------------------------------------------------------------
%                                    mmintershow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                  mmse2interval 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                       mmse2hmt 
%------------------------------------------------------------------------------

%==================================================================================================
% Sup-generating And Inf-generating
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('14:')
%------------------------------------------------------------------------------
%                                     mmthreshad 
%------------------------------------------------------------------------------

a = mmreadgray('../Data/keyb.tif');

%>>> b = mmthreshad(a,uint8(10), uint8(50))
b = nrtReadData('../nrtData/14 - Sup-generating And Inf-generating/mmthreshad.txt','b');
nrt({b},'mmthreshad',{a,uint8(10), uint8(50)});

%>>> c = mmthreshad(a,238)
c = nrtReadData('../nrtData/14 - Sup-generating And Inf-generating/mmthreshad.txt','c');
nrt({c},'mmthreshad',{a,238});

%>>> mmshow(a)
%>>> mmshow(b)
%>>> mmshow(c)

%------------------------------------------------------------------------------
%                                     mminfcanon 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                       mminfgen 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                     mmsupcanon 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                       mmsupgen 
%------------------------------------------------------------------------------

f=mmbinary([
   [0,0,1,0,0,1,1],
   [0,1,0,0,1,0,0],
   [0,0,0,1,1,0,0]]);
i=mmendpoints();

%>>> g=mmsupgen(f,i)
g = ...
[[0 0 0 0 0 0 0]
 [0 1 0 0 0 0 0]
 [0 0 0 0 0 0 0]];
nrt({g},'mmsupgen',{f,i});

a=mmreadgray('../Data/gear.tif');
%>>> b=mmsupgen(a,mmendpoints())
b = nrtReadData('../nrtData/14 - Sup-generating And Inf-generating/mmsupgen.txt','b');
nrt({b},'mmsupgen',{a,mmendpoints()});

%>>> mmshow(a)
%>>> mmshow(mmdil(b))

%==================================================================================================
% Thinning And Thickening
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('15:')
%------------------------------------------------------------------------------
%                                       mmcthick 
%------------------------------------------------------------------------------

f=mmreadgray('../Data/blob2.tif');
t=mmse2hmt(mmbinary([[0,0,0];[0,0,1];[1,1,1]]),
           mmbinary([[0,0,0];[0,1,0];[0,0,0]]));
%>>> print mmintershow(t)

%>>> f1=mmthick(f,t,40); % The thickening makes the image border grow
f1 = nrtReadData('../nrtData/15 - Thinning And Thickening/mmcthick.txt','f1');
nrt({f1},'mmthick',{f,t,40});

%>>> mmshow(f)
%>>> mmshow(f1)

%>>> f2=mmcthick(f,mmneg(mmframe(f)),t,40) # conditioning to inner pixels
f2 = nrtReadData('../nrtData/15 - Thinning And Thickening/mmcthick.txt','f2');
nrt({f2},'mmcthick',{f,mmneg(mmframe(f)),t,40});

%>>> fn=mmcthick(f,mmneg(mmframe(f)),t) #pseudo convex hull
fn = nrtReadData('../nrtData/15 - Thinning And Thickening/mmcthick.txt','fn');
nrt({fn},'mmcthick',{f,mmneg(mmframe(f)),t});

%>>> mmshow(f2)
%>>> mmshow(fn,f)

%------------------------------------------------------------------------------
%                                        mmcthin 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                   mmcwatershed 
%------------------------------------------------------------------------------

a = uint8([
    [10,   10,   10,   10,   10,   10,   10],
    [10,    9,    6,   18,    6,    5,   10],
    [10,    9,    6,   18,    6,    8,   10],
    [10,    9,    9,   15,    9,    9,   10],
    [10,    9,    9,   15,   12,   10,   10],
    [10,   10,   10,   10,   10,   10,   10]]);
b = mmcmp(a,'==',uint8(6));

%>>> print mmcwatershed(a,b)
r = ...
[[0 0 0 1 0 0 0]
 [0 0 0 1 0 0 0]
 [0 0 0 1 0 0 0]
 [0 0 0 1 0 0 0]
 [0 0 0 1 0 0 0]
 [0 0 0 0 1 0 0]];
nrt({r},'mmcwatershed',{a,b});

%>>> print mmcwatershed(a,b,mmsecross(),'REGIONS')
r = ...
[[1 1 1 1 2 2 2]
 [1 1 1 1 2 2 2]
 [1 1 1 1 2 2 2]
 [1 1 1 1 2 2 2]
 [1 1 1 1 2 2 2]
 [1 1 1 1 2 2 2]];
nrt({r},'mmcwatershed',{a,b,mmsecross(),'REGIONS'});

% TODO

%------------------------------------------------------------------------------
%                                         mmskiz 
%------------------------------------------------------------------------------

% TODO

%------------------------------------------------------------------------------
%                                   mmswatershed 
%------------------------------------------------------------------------------

% Not implemented yet

%------------------------------------------------------------------------------
%                                        mmthick 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                         mmthin 
%------------------------------------------------------------------------------

f=mmreadgray('../Data/scissors.tif');

%>>> f1=mmthin(f)
f1 = nrtReadData('../nrtData/15 - Thinning And Thickening/mmthin.txt','f1');
nrt({f1},'mmthin',{f});

%>>> f2=mmthin(f1,mmendpoints(),15) % prunning 15 pixels
f2 = nrtReadData('../nrtData/15 - Thinning And Thickening/mmthin.txt','f2');
nrt({f2},'mmthin',{f1,mmendpoints(),15});

%>>> mmshow(f,f1) % skeleton
%>>> mmshow(f,f2) % prunned skeleton

%------------------------------------------------------------------------------
%                                    mmwatershed 
%------------------------------------------------------------------------------

% TODO

%==================================================================================================
% Measurements
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('16:')
%------------------------------------------------------------------------------
%                                    mmhistogram 
%------------------------------------------------------------------------------

f=uint8([0, 1, 1, 2, 2, 2, 5, 3, 5]);

%>>> h=mmhistogram(f)
c = [0 1 2 3 4 5];                        % MATLAB (PAS DANS PYTHON)
h = [1 2 3 1 0 2];                        % MATLAB
nrt({c,h},'mmhistogram',{f});

f=mmreadgray('../Data/lenina.tif');
%>>> h=mmhistogram(f)                     % Forme differente PYTHON, MATLAB
c = 0:255;
h = nrtReadData('../nrtData/16 - Measurements/mmhistogram.txt','h');
nrt({c,h},'mmhistogram',{f});

%>>> mmshow(f)
%>>> mmplot([[h]],[['style', 'impulses']])

%------------------------------------------------------------------------------
%                                        mmlabel 
%------------------------------------------------------------------------------

f=mmbinary([
   [0,1,0,1,1],
   [1,0,0,1,0]]);

%>>> g=mmlabel(f)
g = [
   0   2   0   3   3
   1   0   0   3   0];
nrt({g},'mmlabel',{f});

f = mmreadgray('../Data/blob3.tif');

%>>> g=mmlabel(f)
g = nrtReadData('../nrtData/16 - Measurements/mmlabel.txt','g');
nrt({g},'transpose',{mmlabel(transpose(f))});

%>>> nblobs=mmstats(g,'max')
%>>> print nblobs
%18.0

%>>> mmshow(f)
%>>> mmlblshow(g)

%------------------------------------------------------------------------------
%                                         mmblob 
%------------------------------------------------------------------------------

fr=uint8([
   [1,1,1,0,0,0],
   [1,1,1,0,0,2],
   [1,1,1,0,2,2]]);

%>>> f_area=mmblob(fr,'area')
f_area = ...
[[9 9 9 0 0 0]
 [9 9 9 0 0 3]
 [9 9 9 0 3 3]];
nrt({f_area},'mmblob',{fr,'area'});

%>>> f_cent=mmblob(fr,'centroid')
f_cent = ...
[[0 0 0 0 0 0]
 [0 1 0 0 1 0]
 [0 0 0 0 0 0]];
nrt({f_cent},'mmblob',{fr,'centroid'});

%>>> f_bb=mmblob(fr,'boundingbox')
f_bb = ...
[[1 1 1 0 0 0]
 [1 0 1 0 1 1]
 [1 1 1 0 1 1]];
nrt({f_bb},'mmblob',{fr,'boundingbox'});

%>>> d_area=mmblob(fr,'area','data')
d_area = ...
[[9]
 [3]];
nrt({d_area},'mmblob',{fr,'area','data'});

%>>> d_cent=mmblob(fr,'centroid','data')
d_cent = [
   2   2
   2   5];
nrt({d_cent},'mmblob',{fr,'centroid','data'});

%>>> d_bb=mmblob(fr,'boundingbox','data')
d_bb = [
   1   1   3   3
   2   5   3   6];
nrt({d_bb},'mmblob',{fr,'boundingbox','data'});

f=mmreadgray('../Data/blob3.tif');
fr=mmlabel(f);

%>>> g=mmblob(fr,'area')
g = nrtReadData('../nrtData/16 - Measurements/mmblob.txt','g');
nrt({g},'mmblob',{fr,'area'});

%>>> mmshow(f)
%>>> mmshow(g)

f=mmreadgray('../Data/blob3.tif');
fr=mmlabel(f);

%>>> centr=mmblob(fr,'centroid')
centr = nrtReadData('../nrtData/16 - Measurements/mmblob.txt','centr');
nrt({centr},'mmblob',{fr,'centroid'});

%>>> mmshow(f,mmdil(centr))

f=mmreadgray('../Data/blob3.tif');
fr=mmlabel(f);

%>>> box=mmblob(fr,'boundingbox')
box = nrtReadData('../nrtData/16 - Measurements/mmblob.txt','box');
nrt({box},'mmblob',{fr,'boundingbox'});

%>>> mmshow(f,box)

%------------------------------------------------------------------------------
%                                        mmgrain 
%------------------------------------------------------------------------------

f=uint8([0:5;0:5;0:5]);
%fr=mmlabelflat(f);
fr = ([
   [1,2,3,4,5,6],
   [1,2,3,4,5,6],
   [1,2,3,4,5,6]]);

%>>> mmgrain(fr,f,'sum','data')
r = [[  0.],
     [  3.],
     [  6.],
     [  9.],
     [ 12.],
     [ 15.]];
nrt({r},'mmgrain',{fr,f,'sum','data'});

%>>> mmgrain(fr,f,'sum')
r = [[ 0,  3,  6,  9, 12, 15],
     [ 0,  3,  6,  9, 12, 15],
     [ 0,  3,  6,  9, 12, 15]];
nrt({r},'mmgrain',{fr,f,'sum'});

% TODO

%------------------------------------------------------------------------------
%                                    mmlabelflat 
%------------------------------------------------------------------------------

f=uint8([
   [5,5,8,3,0],
   [5,8,8,0,2]]);

%>>> g=mmlabelflat(f)
g = [
   1   1   2   3   5
   1   2   2   4   6];
nrt({g},'mmlabelflat',{f});

%>>> g1=mmlabelflat(f,mmsecross(),2)                  % PYTHON NOT IMPLEMENTED
%g1 = ...
%[[1 1 2 3 4]
% [1 2 2 4 4]];
%nrt({g1},'mmlabelflat',{f,mmsecross(),2},'not yet');

% TODO

%------------------------------------------------------------------------------
%                                      mmpatspec 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                        mmstats 
%------------------------------------------------------------------------------

%==================================================================================================
% Visualization
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('17:')
%------------------------------------------------------------------------------
%                                     mmglblshow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                        mmgshow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                       mmdtshow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                      mmlblshow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                         mmshow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                        mmbshow 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                         mmplot 
%------------------------------------------------------------------------------

%==================================================================================================
% Obsolete
%==================================================================================================
%fprintf('%d',NRT_COL);
%NRT_COL = 0;
%fprintf('\n  ')
%pb('18: ///')
%------------------------------------------------------------------------------
%                                        mmvdome 
%------------------------------------------------------------------------------

%==================================================================================================
% Python functions
%==================================================================================================
fprintf('%d',NRT_COL);
NRT_COL = 0;
fprintf('\n  ')
pb('19:')
%------------------------------------------------------------------------------
%                                      mmadd4dil 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                       mmpad4se 
%------------------------------------------------------------------------------

fprintf('%d',NRT_COL);
%==================================================================================================
% END END END END END END END END END END END END END END END END END END END END END END END END
%==================================================================================================
t = cputime - t_begin;
h = floor(t/3600);
m = floor(t/60 - h*60);
s = floor(t - m*60 - h*3600);

fprintf('\n');
pcc(sprintf('----------------------------------\n'))
pcc(sprintf('|            %4d NRT tests done |\n',NRT_NBR))
pcc(sprintf('|      %10s numbers tested |\n',int2bank(NRT_SUM)))
pcc(sprintf('| %2d hours %2d minutes %2d seconds |\n',h,m,s))
pcc(sprintf('----------------------------------\n'))

system("vlc --quiet --verbose 0 --play-and-exit \"sirene_de_bateau.wav\"");
