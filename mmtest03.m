%%% addpath('/usr/share/octave/packages/image-2.0.0/')

TESTmmdairport    = false;
TESTmmdarea       = false;
TESTmmdasp        = false;
TESTmmdlabeltext  = false;
%TESTmmdbeef
TESTmmdblob       = false;
%TESTmmdbrain 
TESTmmdcalc       = false; % TODO
%TESTmmdcells 
TESTmmdchickparts = false;
%TESTmmdconcrete 
TESTmmdcookies    = false; % TODO
%TESTmmdcornea 
%TESTmmdfabric 
TESTmmdfila       = false;
TESTmmdflatzone   = false;       % TODO
TESTmmdflow       = false;
TESTmmdgear       = false;
TESTmmdholecenter = false;       % TODO
TESTmmdleaf       = false;
TESTmmdlith       = false;
TESTmmdpcb        = false;
TESTmmdpieces     = false;
TESTmmdpotatoes   = false;
TESTmmdrobotop    = false;
TESTmmdruler      = false;
TESTmmdsoil       = false;       % TODO

%==============================================================================
% Demonstrations
%==============================================================================

%------------------------------------------------------------------------------
%                                                                   mmdairport 
%------------------------------------------------------------------------------
if TESTmmdairport,

f = mmreadgray('../Data/galeao.jpg');
subplot(1,1,1); mmshow(f)

th=mmopenth(f,mmsedisk(5));
mmshow(uint8(mmaddm(th, 150)))

bin=mmthreshad(th,30);
mmshow(f,bin)

m1=mmthin(bin);
m2=mmthin(m1,mmendpoints());
m=mmareaopen(m2,1000,mmsebox());
mmshow(f,m1,m2,m)

g=mminfrec(mmgray(m), th);
mmshow(g)

final=mmthreshad(g, 20);
mmshow(f, final)

end
%------------------------------------------------------------------------------
%                                                                      mmdarea 
%------------------------------------------------------------------------------
if TESTmmdarea,

a = mmreadgray('../Data/circuit_bw.tif');
a = centerpart(a);
mmshow(a)

b = mmareaopen(a,200);
mmshow(b)

mmshow(a,b)

end
%------------------------------------------------------------------------------
%                                                                       mmdasp
%------------------------------------------------------------------------------
if TESTmmdasp,

a = mmreadgray('../Data/astablet.tif');
mmshow(a)

%b = mmsurf(a)                            % TODO mmsurf n'est pas defini
c = mmregmax(a,mmsebox());
%subplot(1,2,1); mmshow(b)
%subplot(1,2,2); mmshow(b,c)

d = mmopen(a, mmsedisk(20));
%e = mmsurf(d)
f = mmregmax(d,mmsebox());
%subplot(1,2,1); mmshow(e)
%subplot(1,2,2); mmshow(e,f)

subplot(1,2,1); mmshow(a)
subplot(1,2,2); mmshow(f)

end
%------------------------------------------------------------------------------
%                                                                 mmdlabeltext
%------------------------------------------------------------------------------
if TESTmmdlabeltext,

f = mmreadgray('../Data/stext.tif');
subplot(4,1,1); mmshow(f)

fl=mmlabel(f,mmsebox());
h = mmlblshow(fl);
subplot(4,1,2); imshow(uint8(h))

sew = mmimg2se(mmbinary(ones(7,11)));
mmseshow(sew)
fw=mmlabel(f,sew);
h = mmlblshow(fw);
subplot(4,1,3); imshow(uint8(h))

sep = mmimg2se(mmbinary(ones(20,35)));
fp=mmlabel(f,sep);
h = mmlblshow(fp);
subplot(4,1,4); imshow(uint8(h))

end
%------------------------------------------------------------------------------
%                                                                      mmdbeef    
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                                                      mmdblob     
%------------------------------------------------------------------------------
if TESTmmdblob,                                    % TODO A REECRIRE

f  = mmreadgray('../Data/blob3.tif');
fr = mmlabel(f);
nblobs=mmstats(fr,'max')

h = mmlblshow(fr,'border');
%subplot(1,2,1); mmshow(f)
%subplot(1,2,2); imshow(uint8(h))

c  = mmblob(fr,'centroid');
cr = mmlabel(c);

h = mmlblshow(mmdil(cr));
%subplot(1,2,1); mmshow(f,c)
%subplot(1,2,2); imshow(uint8(h))

fbin = mmcmp(cr,'==',uint16(5));
f5   = mmtext('5')

b5   = mmimg2se(f5);
fb5  = mmdil(fbin,b5);

%subplot(1,2,1); mmshow(mmdil(fbin))
%subplot(1,2,2); mmshow(f,fb5)

facc=mmsubm(f,f);
for i = 1:nblobs,
  fbin = mmcmp(cr,'==',uint16(i));
  fi   = mmtext(int2str(i));
  bi   = mmimg2se(fi);
  fbi  = mmdil(fbin,bi);
  facc = mmunion(facc,fbi);
end
darea = mmblob(fr,'area','data');

subplot(1,2,1); mmshow(f,facc)
subplot(1,2,2); stem(1:nblobs,darea)

end
%------------------------------------------------------------------------------
%                                                                     mmdbrain         
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                                                      mmdcalc    
%------------------------------------------------------------------------------
if TESTmmdcalc,

a = mmreadgray('../Data/keyb.tif');                 % TODO
subplot(3,3,1); mmshow(a);

b = mmgradm(a, mmsebox());
subplot(3,3,2); mmshow(b);

c = mmopenth(a,mmsebox(5));
subplot(3,3,3); mmshow(c);

d = mmthreshad(c, uint8(150));
subplot(3,3,4); mmshow(d);

e = mmdil(d, mmsebox(3));
subplot(3,3,5); mmshow(e);

f = mmwatershed(mmneg(e));
subplot(3,3,6); mmshow(f);

g = mmunion(e,f);
subplot(3,3,7); mmshow(b,g);

h = mmcwatershed(b,g,mmsebox());
subplot(3,3,8); mmshow(h);

subplot(3,3,9); mmshow(a,h);

end
%------------------------------------------------------------------------------
%                                                                     mmdcells         
%------------------------------------------------------------------------------

%a = mmreadgray('../Data/bloodcells.tif');
%b = mmareaopen(a, 200);

%subplot(1,2,1); mmshow(a);
%subplot(1,2,2); mmshow(b);

%------------------------------------------------------------------------------
%                                                                mmdchickparts        
%------------------------------------------------------------------------------
if TESTmmdchickparts,

a = mmreadgray('../Data/chickparts.tif');
mmshow(a);

b = mmcmp(a,'>=', uint8(100));
mmshow(b);
c = mmlabel(b);
mmlblshow(c,'border');

d = mmblob(c,'area');
mmshow(d);
mmshow(d, mmcmp(d,'==',0));

wings = mmcmp( uint16(100),'<=',d, '<=', uint16(2500));
mmshow(wings);
tights = mmcmp( uint16(2500),'<',d, '<=', uint16(5500));
mmshow(tights);

legs = mmcmp( uint16(5500), '<', d, '<=', uint16(8500));
mmshow(legs);
breast = mmcmp( d,'>', uint16(8500));
mmshow(breast);

mmshow(a, mmgradm(wings), mmgradm(tights), mmgradm(legs),mmgradm(breast));

end
%------------------------------------------------------------------------------
%                                                                  mmdconcrete 
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                                                   mmdcookies     
%------------------------------------------------------------------------------
if TESTmmdcookies,

a = mmreadgray('../Data/cookies.tif');
a = a(1:floor(end/3),1:floor(end/3));
size(a)
mmshow(a);

b = mmthreshad(a, uint8(100));
mmshow(b);

c = mmopenth(b,mmsedisk(55,'OCTAGON'));
mmshow(c);

%d = mmareaopen(c,400);
%mmshow(d);

%mmshow(a,d);

end
%------------------------------------------------------------------------------
%                                                                    mmdcornea  
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                                                    mmdfabric  
%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
%                                                                      mmdfila   
%------------------------------------------------------------------------------
if TESTmmdfila,

a = mmreadgray('../Data/danaus.tif');           % OK TRES LONG 3H
%a = centerpart(a);
subplot(3,3,1); mmshow(a)

b = mmcloserecth(a,mmsebox(5));
subplot(3,3,2); mmshow(b)

c = mmopen(b);
subplot(3,3,3); mmshow(c)

d = mmareaopen(c,200);
subplot(3,3,4); mmshow(d)

e = mmthreshad(d,50);
subplot(3,3,5); mmshow(e)

f = mmthin(e);
subplot(3,3,6); mmshow(f)

g = mmthin(f,mmendpoints(), 12);
subplot(3,3,7); mmshow(g)

h = mminfrec(g,e);
subplot(3,3,8); mmshow(h)

subplot(3,3,9); mmshow(a,mmbinary(h))          % DIFF mmbinary

end
%------------------------------------------------------------------------------
%                                                                  mmdflatzone       
%------------------------------------------------------------------------------
if TESTmmdflatzone,

a = mmreadgray('../Data/cameraman.tif');
a = a(1:floor(end/4),1:floor(end/4));
size(a)

b   = mmlabelflat(a,mmsebox());
nfz = mmstats(b,'max')
h   = mmlblshow(b);
subplot(3,3,1); mmshow(a)
subplot(3,3,2); imshow(uint8(h))

c = mmasfrec(a,'CO',mmsebox(),mmsebox(),2);
d = mmasfrec(a,'CO',mmsebox(),mmsebox(),4);
e = mmasfrec(a,'CO',mmsebox(),mmsebox(),16);
subplot(3,3,4); mmshow(c)
subplot(3,3,5); mmshow(d)
subplot(3,3,6); mmshow(e)

c_lab=mmlabelflat(c,mmsebox());
d_lab=mmlabelflat(d,mmsebox());
e_lab=mmlabelflat(e,mmsebox());
mmstats(c_lab,'max')
mmstats(d_lab,'max')
mmstats(e_lab,'max')
h1 = mmlblshow(c_lab);
h2 = mmlblshow(d_lab);
h3 = mmlblshow(e_lab);
subplot(3,3,7); imshow(uint8(h1))
subplot(3,3,8); imshow(uint8(h2))
subplot(3,3,9); imshow(uint8(h3))

end
%------------------------------------------------------------------------------
%                                                                      mmdflow      
%------------------------------------------------------------------------------
if TESTmmdflow,

a = mmreadgray('../Data/flow.tif');
subplot(3,2,1); mmshow(a)

b = mmcloseth(a,mmseline(50,90));
subplot(3,2,2); mmshow(b)

c = mmcloserec(b,mmsebox(5));
subplot(3,2,3); mmshow(c)

d = mmasf(c,'co',mmsecross());
subplot(3,2,4); mmshow(d)

e = mmthreshad(d,100);
subplot(3,2,5); mmshow(a)
subplot(3,2,6); mmshow(a,e)

end
%------------------------------------------------------------------------------
%                                                                      mmdgear    
%------------------------------------------------------------------------------
if TESTmmdgear,

subplot(111)
a = mmreadgray('../Data/gear.tif');
subplot(3,2,1); mmshow(a);

b = mmopen(a,mmsedisk(20));
subplot(3,2,3); mmshow(b);
c = mmsubm(a,b);
subplot(3,2,4); mmshow(c);

d = mmlabel(c);
nteeth = mmstats(d,'max')
h = mmlblshow(d,'border');
subplot(3,2,5); imshow(uint8(h))

end
%------------------------------------------------------------------------------
%                                                                mmdholecenter       
%------------------------------------------------------------------------------
if TESTmmdholecenter,

a = mmreadgray('../Data/pcbholes.tif');
mmshow(a)

b = mmclohole(a);
mmshow(b)
d = mmdist(b,mmsecross(),'EUCLIDEAN')
e = mmregmax(d,mmsebox())
f = mmthreshad(d, uint8([20]))   % radius larger than 20 pixels
g = mmintersec(e,f)
h = mmblob(mmlabel(g,mmsebox()),'CENTROID'); % pad center
mmshow(b,mmdil(h))

end
%------------------------------------------------------------------------------
%                                                                      mmdleaf  
%------------------------------------------------------------------------------
if TESTmmdleaf,

subplot(111)
f = mmreadgray('../Data/leaf.tif');
f = f(1:floor(end/1),1:floor(end/1));
size(f)
subplot(5,3,1); mmshow(f)

f_low  = mmthreshad(f,100);
f_med  = mmthreshad(f,128);
f_high = mmthreshad(f,160);
subplot(5,3,4); mmshow(f_low)
subplot(5,3,5); mmshow(f_med)
subplot(5,3,6); mmshow(f_high)

f1 = mmtoggle(f,mmero(f,mmsedisk(7)),mmdil(f,mmsedisk(7)));
subplot(5,3,7); mmshow(f1)

f2 = mmthreshad(f1,100);
f3 = mmareaopen(f2,80);
subplot(5,3,10); mmshow(f2)
subplot(5,3,11); mmshow(f3)

f4 = mmgradm(f3);
subplot(5,3,13); mmshow(f,f4)

end
%------------------------------------------------------------------------------
%                                                                      mmdlith 
%------------------------------------------------------------------------------
if TESTmmdlith,

subplot(111)
a = mmreadgray('../Data/r4x2_256.tif');
subplot(5,2,1); mmshow(a);
%%% subplot(5,2,2); mmshow(mmsurf(a));         % TODO mmsurf

b = mmclose(a,mmseline(25,90));
subplot(5,2,3); mmshow(b);
%%% subplot(5,2,4); mmshow(mmsurf(b));         % TODO mmsurf

c = mmsubm(b,a);
subplot(5,2,5); mmshow(c);
%%% subplot(5,2,6); mmshow(mmsurf(c));         % TODO mmsurf

d = mmcmp(c,'>=',50);
e = mmareaopen(d,5);
subplot(5,2,7); mmshow(d);
subplot(5,2,8); mmshow(e);

subplot(5,2,9);  mmshow(a,e);
%%% subplot(5,2,10); mmshow(mmsurf(a),e);      % TODO mmsurf

end
%------------------------------------------------------------------------------
%                                                                       mmdpcb
%------------------------------------------------------------------------------
if TESTmmdpcb,

subplot(111)
a = mmreadgray('../Data/pcb1bin.tif');
size(a)
mmshow(a);

b = mmclohole(a);
holes = mmsubm(b,a);
mmshow(b);
mmshow(a, holes);

c = mmopen(b,mmsebox(8));
square = mmcdil(c, a);
mmshow(b, c);
mmshow(holes, square);

f = mmsubm(b, c);
g = mmopen(f, mmsedisk(8));
circle = mmcdil(g,a);
mmshow(f, g);
mmshow(holes, square, circle);

i = mmsubm(f, g);
m = mmopen(i,mmsedil(mmseline(8,90), mmseline(25)));
rect = mmcdil(m,a);
mmshow(i, m);
mmshow(holes, square, circle, rect);

o = mmsubm(i,m);
p = mmopen(o, mmsebox(2));
thin = mmcdil(p,a);
mmshow(o, p);
mmshow(holes, square, circle, rect, thin);

r = mmsubm(o,p);
s = mmopen(r, mmsebox());
thick = mmcdil(s,a);
mmshow(r, s);
mmshow(holes, square, circle, rect, thin, thick);

mmshow(holes, square, circle, rect, thin, thick);

end
%------------------------------------------------------------------------------
%                                                                    mmdpieces    
%------------------------------------------------------------------------------
if TESTmmdpieces,

a = mmreadgray('../Data/pieces_bw.tif');
size(a)
mmshow(a);

seA = mmimg2se(mmbinary([[0,1,0],[1,0,1],[0,0,0]]))
seB = mmimg2se(mmbinary([[0,0,0],[0,1,0],[0,0,0]]))
iAB = mmse2hmt(seA,seB);
mmintershow(iAB)
b = mmthick(a, iAB);
mmshow(b);

c = mmthin(b);
mmshow(c);

d = mmthin(c,mmendpoints());
mmshow(c,d);

e = mminfrec(d,b);
mmshow(e);

f = mmintersec(a,e);
mmshow(f);

g = mmsubm(c,e);
mmshow(g);

h = mmthin(g, mmendpoints(), 4);
mmshow(h);

seA1 = mmimg2se(mmbinary([[0,1,0];[0,1,0];[1,0,1]]))
seB1 = mmimg2se(mmbinary([[0,0,0];[1,0,1];[0,1,0]]))
seA2 = mmimg2se(mmbinary([[0,1,0];[1,1,1];[0,0,0]]))
seB2 = mmimg2se(mmbinary([[1,0,1];[0,0,0];[0,1,0]]))
i1 = mmsupcanon(h, mmse2hmt(seA1,seB1));
i2 = mmsupcanon(h, mmse2hmt(seA2,seB2));
i = mmunion(i1,i2);
mmshow(h,mmdil(i,mmsedisk(2)));

j = mminfrec(i,b,mmsebox());
mmshow(j);

k = mmintersec(a,j);
mmshow(k);

l = mmsubm(mmsubm(a,f),k);
mmshow(l);

m = mmgray(f,'uint8',1);
n = mmgray(k,'uint8',2);
o = mmgray(l,'uint8',3);
p = mmunion(m,n,o);
h = mmlblshow(p);
imshow(uint8(h))

end
%------------------------------------------------------------------------------
%                                                                  mmdpotatoes    
%------------------------------------------------------------------------------
if TESTmmdpotatoes,

a = mmreadgray('../Data/potatoes.tif');
mmshow(a);

b = mmthreshad(a,90);
mmshow(b);

c = mmthin(b);
mmshow(a,c);

d = mmcloseth(a,mmsedisk(5));
mmshow(d);


e = mmthreshad(d,20);
f = mmintersec(e,b);
mmshow(f);

mmshow(a);
mmshow(a,f,c);

end
%------------------------------------------------------------------------------
%                                                                   mmdrobotop   
%------------------------------------------------------------------------------
if TESTmmdrobotop,

a = mmreadgray('../Data/robotop.tif');
mmshow(a);

b = mmopenth(a,mmsebox(4));
mmshow(b);

c = mmopen(b,mmsebox());
mmshow(c);

d = mmthreshad(c,100);
mmshow(a,d);

end
%------------------------------------------------------------------------------
%                                                                     mmdruler 
%------------------------------------------------------------------------------
if TESTmmdruler,

a = mmreadgray('../Data/mm3.tif');
mmshow(a);

b = mmthreshad( mmcloseth(a,mmsebox(5)),40);
mmshow(b);

c = mmopen(b,mmseline(50,90));
mmshow(c);

d =mmclose(c,mmseline(15));
mmshow(d);

e = mminfrec(d,b);
mmshow(e);

f = mminfrec(d,b,mmseline(3,90));
mmshow(f);

g = mmsubm(e,f);
mmshow(g);

h = mmopen(g);
mmshow(h);

i = mminfrec(h, b);
mmshow(i);

mmshow(a,i);

end
%------------------------------------------------------------------------------
%                                                                      mmdsoil   
%------------------------------------------------------------------------------
if TESTmmdsoil,

a = mmreadgray('../Data/soil.tif');
a = a(1:floor(end/3),1:floor(end/3));
size(a)
mmshow(a);

b = mmcloseth(a,mmsebox(2));
mmshow(b);

c= mmareaopen(b,80,mmsebox());
mmshow(c);

d = mmthreshad(c,15);
mmshow(d);

mmshow(a,d);

end
%==============================================================================
% END END END END END END END END END END END END END END END END END END END
%==============================================================================
