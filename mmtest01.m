%%% addpath('/usr/share/octave/packages/image-2.0.0/')
 
%---------------------------------------------------------------
% mmreadgray
%---------------------------------------------------------------
%a = imread('../Data/cookies.tif');

%a = mmreadgray('../Data/cookies.tif');
%imshow(a)

%---------------------------------------------------------------
%  mmdil
%---------------------------------------------------------------

%f=[
%   [0, 0, 0, 0, 0, 0, 1],
%   [0, 1, 0, 0, 0, 0, 0],
%   [0, 0, 0, 0, 1, 0, 0]]
%b=[1, 1, 0]
%mmdil(f,b)

%f=uint8([
%   [ 0,   1,  2, 50,  4,  5],
%   [ 2,   3,  4,  0,  0,  0],
%   [12, 255, 14, 15, 16, 17]])
%mmdil(f,b)

%%f=mmbinary(mmreadgray('../Data/blob.tif'));
%%bimg=mmbinary(mmreadgray('../Data/blob1.tif'));
%%b=mmimg2se(bimg);

%%subplot(2,2,1); mmshow(f)
%%subplot(2,2,2); mmshow(mmdil(f,b))
%%subplot(2,2,3); mmshow(mmdil(f,b),mmgradm(f))

%f=mmreadgray('../Data/pcb_gray.tif');
%b=mmsedisk(5);

%subplot(1,2,1); mmshow(f)
%subplot(1,2,2); mmshow(mmdil(f,b))

%---------------------------------------------------------------
% mmbinary
%---------------------------------------------------------------
%a = [0, 1, 2, 3, 4]
%b=mmbinary(a)
            
%a=mmreadgray('../Data/mm3.tif');
%b=mmbinary(a,82);
%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)
%subplot(1,1,1)

%---------------------------------------------------------------
% mmhistogram
%---------------------------------------------------------------
%f=[0, 1, 1, 2, 2, 2, 5, 3, 5]
%[counts, x] = mmhistogram(f);

%f=mmreadgray('../Data/lenina.tif');
%subplot(1,2,1); mmshow(f)
%[counts, x] = mmhistogram(f);
%subplot(1,2,2); stem (x, counts)

%---------------------------------------------------------------
% mmaddm 
%---------------------------------------------------------------
%f = uint8([255,   255,    0,   10,    0,   255,   250])
%g = uint8([ 0,    40,   80,   140,  250,    10,    30])
%y1 = mmaddm(f,g)

%y2 = mmaddm(g, 100)

%a = mmreadgray('../Data/keyb.tif');
%b = mmaddm(a,128);
%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%---------------------------------------------------------------
% mmneg
%---------------------------------------------------------------
%f=uint8([255, 255, 0, 10, 20, 10, 0, 255, 255])
%mmneg(f)
%mmneg(uint8([0, 1]))
%%% mmneg(int32([0, 1]))         % NON PRIS EN COMPTE

%a = mmreadgray('../Data/gear.tif');
%b = mmneg(a);
%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)
%pause

%c = mmreadgray('../Data/astablet.tif');
%d = mmneg(c);
%subplot(1,2,1); mmshow(c)
%subplot(1,2,2); mmshow(d)
%pause

%f=([255, 255, 0, 0]);
%mmneg(f)

%---------------------------------------------------------------
% mmsubm 
%---------------------------------------------------------------
%f = uint8([255,   255,    0,   10,   20,   10,    0,   255,  255]);
%g = uint8([10,     20,   30,   40,   50,   40,   30,    20,   10]);
%mmsubm(f,   g)
%mmsubm(f, 100)
%mmsubm(100, f) % RESULTAT DIFFERENT

%a = mmreadgray('../Data/boxdrill-C.tif');
%b = mmreadgray('../Data/boxdrill-B.tif');
%c = mmsubm(a,b);
%subplot(1,3,1); mmshow(a)
%subplot(1,3,2); mmshow(b)
%subplot(1,3,3); mmshow(c)

%---------------------------------------------------------------
% mmintersec 
%---------------------------------------------------------------
%f=uint8([255,  255,    0,   10,    0,   255,   250])
%g=uint8([ 0,    40,   80,   140,  250,    10,    30])
%mmintersec(f, g)
%mmintersec(f, 0)

%a = mmreadgray('../Data/form-ok.tif');
%b = mmreadgray('../Data/form-1.tif');
%c = mmintersec(a,b);
%subplot(2,2,1); mmshow(a)
%subplot(2,2,2); mmshow(b)
%subplot(2,2,3); mmshow(c)

%d = mmreadgray('../Data/tplayer1.tif');
%e = mmreadgray('../Data/tplayer2.tif');
%f = mmreadgray('../Data/tplayer3.tif');
%g = mmintersec(d,e,f);
%subplot(2,3,1); mmshow(d)
%subplot(2,3,2); mmshow(e)
%subplot(2,3,3); mmshow(f)
%subplot(2,3,4); mmshow(g)

%---------------------------------------------------------------
% mmcmp 
%---------------------------------------------------------------
%mmcmp(uint8([1, 2, 3]),'<', uint8(2))
%mmcmp(uint8([1, 2, 3]),'<', uint8([0, 2, 4]))
%mmcmp(uint8([1, 2, 3]),'==', uint8([1, 1, 3]))

%f=mmreadgray('../Data/keyb.tif');
%fbin=mmcmp(uint8(10), '<', f, '<', uint8(50));
%subplot(1,2,1); mmshow(f)
%subplot(1,2,2); mmshow(fbin)

%---------------------------------------------------------------
% mmunion 
%---------------------------------------------------------------
%f=uint8([255, 255,  0,  10,   0, 255, 250])
%g=uint8([  0,  40, 80, 140, 250,  10,  30])
%mmunion(f, g)
%mmunion(f, 255)

%a = mmreadgray('../Data/form-ok.tif');
%b = mmreadgray('../Data/form-1.tif');
%c = mmunion(a,b);
%subplot(2,2,1); mmshow(a)
%subplot(2,2,2); mmshow(b)
%subplot(2,2,3); mmshow(c)

%d = mmreadgray('../Data/danaus.tif');
%e = mmcmp(d,'<',80);
%f = mmunion(d,mmgray(e));
%subplot(2,2,1); mmshow(d)
%subplot(2,2,2); mmshow(e)
%subplot(2,2,3); mmshow(f)

%g = mmreadgray('../Data/tplayer1.tif');
%h = mmreadgray('../Data/tplayer2.tif');
%i = mmreadgray('../Data/tplayer3.tif');
%j = mmunion(g,h,i);
%subplot(2,3,1); mmshow(g)
%subplot(2,3,2); mmshow(h)
%subplot(2,3,3); mmshow(i)
%subplot(2,3,4); mmshow(j)

%---------------------------------------------------------------
%  mmtoggle 
%---------------------------------------------------------------
%f  = uint8([0,1,2,3,4,5,6])
%f1 = uint8([0,0,0,0,0,0,0])
%f2 = uint8([6,6,6,6,6,6,6])
%mmtoggle(f,f1,f2)

%a = mmreadgray('../Data/angiogr.tif');
%b = mmero(a,mmsedisk(2));
%c = mmdil(a,mmsedisk(2));
%d = mmtoggle(a,b,c);
%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(d)

%---------------------------------------------------------------
%  mmtext 
%---------------------------------------------------------------
           %1234567890123456
%y1 = mmtext(' !"#$%&''()*+,-./');
%y2 = mmtext('0123456789:;<=>?');
%y3 = mmtext('@ABCDEFGHIJKLMNO');
%y4 = mmtext('PQRSTUVWXYZ[\]^_');
%y5 = mmtext('`abcdefghijklmno');
%y6 = mmtext('pqrstuvwxyz{|}~');
           %1234567890123456

%subplot(6,1,1); imshow(y1)
%subplot(6,1,2); imshow(y2)
%subplot(6,1,3); imshow(y3)
%subplot(6,1,4); imshow(y4)
%subplot(6,1,5); imshow(y5)
%subplot(6,1,6); imshow(y6)

%---------------------------------------------------------------
%  mmlimits 
%---------------------------------------------------------------
%mmlimits(mmbinary([0, 1, 0]))
%mmlimits(uint8([0, 1, 2]))

%---------------------------------------------------------------
%  mmframe 
%---------------------------------------------------------------
%a = mmreadgray('../Data/cameraman.tif');
%b = mmframe(a);
%c = mmframe(a,1,1,0,0,255);
%d = mmframe(a,2,2,0,0,255);

%subplot(2,3,1); imshow(a)
%subplot(2,3,4); imshow(b)
%subplot(2,3,5); imshow(c)
%subplot(2,3,6); imshow(d)

%---------------------------------------------------------------
%  mmseunion 
%---------------------------------------------------------------
%b1 = [0, 0, 0, 0, 1, 1, 1, 1, 1]
%b2 = [[0, 0, 1, 1, 1, 0, 0],
%       [0, 1, 1, 1, 1, 1, 0],
%       [1, 1, 1, 1, 1, 1, 1],
%       [1, 1, 1, 1, 1, 1, 1],
%       [1, 1, 1, 1, 1, 1, 1],
%       [0, 1, 1, 1, 1, 1, 0],
%       [0, 0, 1, 1, 1, 0, 0]]
%b3 = mmseunion(b1,b2)

%---------------------------------------------------------------
%  mmmat2set 
%---------------------------------------------------------------
%%%f=uint8([[1,2,3];[4,5,6];[7,8,9]]);
%f=uint8([[10,20,30];[40,50,60];[70,80,90]]);
%[i,v] = mmmat2set(f)

%f=uint8([[10,20,30,40];[50,60,70,80]]);
%[i,v] = mmmat2set(f)

%---------------------------------------------------------------
%  mmset2mat 
%---------------------------------------------------------------

%coord = int32([[ 0,0];[-1,0];[ 1,1]]);
%A     = mmset2mat(coord)

%vu    = uint8([1,2,3]);
%f     = mmset2mat(coord,vu)

%---------------------------------------------------------------
%   mmsetrans 
%---------------------------------------------------------------

%b1 = [0, 0, 0, 0, 1, 1, 1, 1, 1]
%b2 = mmsetrans(b1,[2,-2])

%b1 = [0, 1, 1]
%b2 = mmsetrans(b1,[0,0])
%b3 = mmsetrans(b1,[0,1])
%b4 = mmsetrans(b1,[1,0])

%---------------------------------------------------------------
%    mmsedil 
%---------------------------------------------------------------

%b1 = [0, 0, 0, 0, 1, 1, 1, 1, 1]
%b2 = [[0, 1, 1, 1, 0],
%      [1, 1, 1, 1, 1],
%      [1, 1, 1, 1, 1],
%      [1, 1, 1, 1, 1],
%      [0, 1, 1, 1, 0]]
%b3 = mmsedil(b1,b2)

%---------------------------------------------------------------
%    mmsesum 
%---------------------------------------------------------------

%b = [[1, 1, 1];
%     [1, 1, 1];
%     [0, 1, 0]]
%b3 = mmsesum(b,3)

%---------------------------------------------------------------
%     mmserot 
%---------------------------------------------------------------

%b = [[0, 0, 0]; [0, 1, 1]; [0, 0, 0]]
%mmserot(b)
%mmserot(b,45,'ANTI-CLOCKWISE')

%b = [0, 1, 1]
%mmserot(b)
%mmserot(b,45,'ANTI-CLOCKWISE')

%---------------------------------------------------------------
%   mmsereflect 
%---------------------------------------------------------------

%b1 = [[0 0 0 0 0 0 0];
%      [0 0 0 0 0 0 0];
%      [0 0 0 1 0 0 0];
%      [0 0 0 0 1 1 0];
%      [0 0 0 0 0 0 1]]
%b2 = mmsereflect(b1)

%---------------------------------------------------------------
%    mmsebox
%---------------------------------------------------------------
        
%b1 = mmsebox()
%b2 = mmsebox(2)

%---------------------------------------------------------------
%   mmsecross
%---------------------------------------------------------------

%b1 = mmsecross()
%b2 = mmsecross(2)

%---------------------------------------------------------------
%   mmseline
%---------------------------------------------------------------

%mmseline()
%b1 = mmseline(4,45)
%b2 = mmseline(4,-180)
%%%a  = mmtext('Line')      TODO
%%%b  = mmdil(a,b1)         TODO

%---------------------------------------------------------------
%    mmsedisk
%---------------------------------------------------------------

%a=mmsedisk(10,'CITY-BLOCK')
%b=mmsedisk(10,'EUCLIDEAN')
%c=mmsedisk(10,'OCTAGON')

%subplot(1,3,1); imshow(a)
%subplot(1,3,2); imshow(b)
%subplot(1,3,3); imshow(c)

%---------------------------------------------------------------
%   mmedgeoff
%---------------------------------------------------------------

%a=mmreadgray('../Data/form-1.tif');
%b=mmedgeoff(a);

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%---------------------------------------------------------------
%    mminfrec
%---------------------------------------------------------------

%g=mmreadgray('../Data/text_128.tif');
%f=mmero(g,mmseline(9,90));
%y=mminfrec(f,g,mmsebox());

%subplot(1,3,1); mmshow(g)
%subplot(1,3,2); mmshow(f)
%subplot(1,3,3); mmshow(y)

%---------------------------------------------------------------
%   mmconcat
%---------------------------------------------------------------

%f1=mmreadgray('../Data/cameraman.tif');
%f2=mmreadgray('../Data/blob.tif');

%g=mmconcat('W',f1,mmgray(mmneg(f2)));
%h=mmconcat('H',f1,mmgray(mmneg(f2)));
%subplot(1,2,1); mmshow(g);
%subplot(1,2,2); mmshow(h);

%v1 = mmconcat('W',f1,f1);
%v2 = mmconcat('W',f1,f1,f1);
%v3 = mmconcat('W',f1,f1,f1,f1);
%subplot(3,1,1); mmshow(v1)
%subplot(3,1,2); mmshow(v2)
%subplot(3,1,3); mmshow(v3)

%v1 = mmconcat('H',f1,f1);
%v2 = mmconcat('H',f1,f1,f1);
%v3 = mmconcat('H',f1,f1,f1,f1);
%subplot(3,1,1); mmshow(v1)
%subplot(3,1,2); mmshow(v2)
%subplot(3,1,3); mmshow(v3)

% v1 = mmconcat('D',f1,f1);

%---------------------------------------------------------------
%   mmthreshad
%---------------------------------------------------------------

%a = mmreadgray('../Data/keyb.tif');
%b = mmthreshad(a,uint8(10),uint8(50));
%c = mmthreshad(a,238);

%subplot(2,2,1); mmshow(a)
%subplot(2,2,2); mmshow(b)
%subplot(2,2,3); mmshow(c)

%---------------------------------------------------------------
%   mmshow
%---------------------------------------------------------------

%f=mmreadgray('../Data/mribrain.tif');
%f150=mmthreshad(f,150);
%f200=mmthreshad(f,200);

%subplot(2,3,1); mmshow(f);
%subplot(2,3,2); mmshow(f150);
%subplot(2,3,3); mmshow(f200);
%subplot(2,3,4); mmshow(f,f150,f200);

%---------------------------------------------------------------
%    mmdrawv
%---------------------------------------------------------------
%f=uint8(zeros(3,5))
%pcoords=uint16([[1,1],
%                [1,3],
%                [3,5]])
%pvalue=uint16([1,2,3])
%mmdrawv(f,pcoords,pvalue,'point')

%mmdrawv(f,pcoords,pvalue,'line')

%rectcoords=uint16([1,1,3,4])
%mmdrawv(f,rectcoords, uint16(5), 'rect')

%frectcoords=uint16([1,1,3,4])
%mmdrawv(f,frectcoords, uint16(5), 'filledrect')

%---------------------------------------------------------------
%    mmcdil
%---------------------------------------------------------------

%f = mmbinary(uint8([[1, 0, 0, 0, 0, 0, 0];
%                    [0, 0, 0, 0, 0, 0, 0];
%                    [0, 0, 0, 0, 1, 0, 0]]))
%g = mmbinary(uint8([[1, 1, 1, 0, 0, 1, 1];
%                    [1, 0, 1, 1, 1, 0, 0];
%                    [0, 0, 0, 0, 1, 0, 0]]))

%y1=mmcdil(f,g,mmsecross())
%y2=mmcdil(f,g,mmsecross(),3)

%f = uint8([
%    [   0,    0,   0,   80,   0,   0];
%    [   0,    0,   0,    0,   0,   0];
%    [  10,   10,   0,  255,   0,   0]])
%g = uint8([\
%    [   0,    1,   2,   50,   4,   5];
%    [   2,    3,   4,    0,   0,   0];
%    [  12,  255,  14,   15,  16,  17]])

%y1=mmcdil(f,g,mmsecross())
%y2=mmcdil(f,g,mmsecross(),3)

%g=mmreadgray('../Data/pcb1bin.tif');
%f=mmframe(g,5,5);
%y5=mmcdil(f,g,mmsecross(),5);
%y25=mmcdil(f,g,mmsecross(),25);

%subplot(2,2,1); mmshow(g)
%subplot(2,2,2); mmshow(g,f)
%subplot(2,2,3); mmshow(g,y5)
%subplot(2,2,4); mmshow(g,y25)

%%%g=mmneg(mmreadgray('../Data/n2538.tif'));
%%%f=mmintersec(g,0);
%%%f=mmdraw(f,'LINE:40,30,60,30:END');
%%%y1=mmcdil(f,g,mmsebox());
%%%y30=mmcdil(f,g,mmsebox(),30);
%%% mmshow(g)
%%% mmshow(f)
%%% mmshow(y1)
%%% mmshow(y30)
        
%---------------------------------------------------------------
%  mminfrec              TODO
%---------------------------------------------------------------

%g=mmreadgray('../Data/text_128.tif');
%f=mmero(g,mmseline(9,90));
%y=mminfrec(f,g,mmsebox());

%subplot(1,3,1); mmshow(g)
%subplot(1,3,2); mmshow(f)
%subplot(1,3,3); mmshow(y)

%---------------------------------------------------------------
%  mminfrec              TODO
%---------------------------------------------------------------

%a=mmreadgray('../Data/form-1.tif');
%b=mmedgeoff(a);

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%---------------------------------------------------------------
%   mmgradm
%---------------------------------------------------------------

%a = mmreadgray('../Data/small_bw.tif');
%b = mmgradm(a);

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%c = mmgradm(a,mmsecross(0),mmsecross());
%d = mmgradm(a,mmsecross(),mmsecross(0));

%subplot(1,2,1); mmshow(a,c)
%subplot(1,2,2); mmshow(a,d)

%a = mmreadgray('../Data/bloodcells.tif');
%b = mmgradm(a);

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)  

%---------------------------------------------------------------
%    mmcloseth
%---------------------------------------------------------------     
        
%a = mmreadgray('../Data/danaus.tif');
%b = mmcloseth(a,mmsebox(5));

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%---------------------------------------------------------------
%     mmbshow
%--------------------------------------------------------------- 

%f1=mmtext('b');
%f2=mmtext('w');
%g2=mmbshow(f1,f2);
%subplot(1,2,1); mmshow(g2)

%f3=mmtext('x');
%g3=mmbshow(f1,f2,f3);
%subplot(1,2,2); mmshow(g3);

%---------------------------------------------------------------
%      mmstats
%--------------------------------------------------------------- 

%mmstats([[10,20,30];[40,50,60];[70,80,90]],'max')
%mmstats([[10,20,30];[40,50,60];[70,80,90]],'min')
%mmstats([[10,20,30];[40,50,60];[70,80,90]],'mean')
%mmstats([[10,20,30];[40,50,60];[70,80,90]],'median')
%mmstats([[10,20,30];[40,50,60];[70,80,90]],'std')
%%% mmstats([[10,20,30];[40,50,60];[70,80,90]],'aaa')

%---------------------------------------------------------------
%       mmglblshow
%--------------------------------------------------------------- 

%x = [[1 2 3];[4 5 6];[7 8 9]]
%Y = mmglblshow(x)
%imshow(uint8(Y))

%---------------------------------------------------------------
%     mmopenth
%---------------------------------------------------------------

%a = mmreadgray('../Data/keyb.tif');
%b = mmopenth(a,mmsebox(3));

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%---------------------------------------------------------------
%   mmisequal
%---------------------------------------------------------------

%f1 = uint8(0:3)
%f2 = uint8([9, 5, 3, 3])
%f3 = f1

%mmisequal(f1,f2)
%mmisequal(f1,f3)

%---------------------------------------------------------------
%    mmislesseq
%---------------------------------------------------------------

%f1 = uint8([0, 1, 2, 3])
%f2 = uint8([9, 5, 3, 3])

%mmislesseq(f1,f2)
%mmislesseq(f2,f1)
%mmislesseq(f1,f1)

%---------------------------------------------------------------
%    mmis
%---------------------------------------------------------------

%fbin=mmbinary([0, 1])
%f1=uint8([1, 2, 3])
%f2=uint8([2, 2, 3])
%f3=uint8([2, 3, 4])

%mmis(fbin,'binary')
%mmis(f1,'gray')
%mmis(f1,'==',f2)
%mmis(f1,'<',f3)
%mmis(f1,'<=',f2)
%mmis(f1,'<=',f2,'<=',f3)

%---------------------------------------------------------------
%   mmskelm
%---------------------------------------------------------------

%a=mmneg(mmframe(mmbinary(ones(7,9))))
%mmskelm(a)
%mmskelm(a,mmsebox())

%a=mmreadgray('../Data/pcbholes.tif');
%b=mmskelm(a);
%c=mmskelm(a,mmsecross(),'value');

%subplot(2,2,1); mmshow(a)
%subplot(2,2,2); mmshow(b)
%subplot(2,2,3); mmshow(c)

%---------------------------------------------------------------
%   mmskelmrec
%---------------------------------------------------------------

%a=mmneg(mmframe(mmbinary(ones(7,9))))
%b=mmskelm(a,mmsecross(),'value')
%c=mmskelmrec(b,mmsecross())

%---------------------------------------------------------------
%   mmintershow
%---------------------------------------------------------------

%mmintershow(mmhomothin())

%---------------------------------------------------------------
%   mmendpoints
%---------------------------------------------------------------

%mmintershow(mmendpoints())
%mmintershow(mmendpoints('HOMOTOPIC'))

%f  = mmreadgray('../Data/pcbholes.tif');
%f1 = mmthin(f);
%f2 = mmthin(f1,mmendpoints(),20);

%subplot(2,2,1); mmshow(f1)
%subplot(2,2,2); mmshow(f)
%subplot(2,2,3); mmshow(f2)

%fn = mmthin(f1,mmendpoints('HOMOTOPIC'));
%mmshow(mmdil(fn))

%---------------------------------------------------------------
%   mmhomothick
%---------------------------------------------------------------

%mmintershow(mmhomothick())

%---------------------------------------------------------------
%   mminterot
%---------------------------------------------------------------

%b1 = mmendpoints();
%b2 = mminterot(b1);

%mmintershow(b1)
%mmintershow(b2)

%---------------------------------------------------------------
%    mmsupgen
%---------------------------------------------------------------

%f=mmbinary([
%   [0,0,1,0,0,1,1],
%   [0,1,0,0,1,0,0],
%   [0,0,0,1,1,0,0]])
%i=mmendpoints();
%mmintershow(i)
%g=mmsupgen(f,i)

%---------------------------------------------------------------
%   mmthin
%---------------------------------------------------------------

%f=mmreadgray('../Data/scissors.tif');
%f1=mmthin(f);
%f2=mmthin(f1,mmendpoints(),15); % prunning 15 pixels

%subplot(1,2,1); mmshow(f,f1)   % skeleton
%subplot(1,2,2); mmshow(f,f2)   % prunned skeleton

%---------------------------------------------------------------
%   mmcthick
%---------------------------------------------------------------

%f=mmreadgray('../Data/blob2.tif');
%t=mmse2hmt(mmbinary([[0,0,0];[0,0,1];[1,1,1]]),
%           mmbinary([[0,0,0];[0,1,0];[0,0,0]]));
%mmintershow(t)
%f1=mmthick(f,t,40); % The thickening makes the image border grow

%subplot(1,2,1); mmshow(f)
%subplot(1,2,2); mmshow(f1)

%f2=mmcthick(f,mmneg(mmframe(f)),t,40); % conditioning to inner pixels
%fn=mmcthick(f,mmneg(mmframe(f)),t);    % pseudo convex hull

%subplot(1,2,1); mmshow(f2)
%subplot(1,2,2); mmshow(fn,f)

%---------------------------------------------------------------
%   mmcloserecth
%---------------------------------------------------------------

%a = mmreadgray('../Data/danaus.tif');
%b = mmcloserecth(a,mmsebox(4));

%subplot(1,2,1); mmshow(a)
%subplot(1,2,2); mmshow(b)

%---------------------------------------------------------------
%   mmcbisector
%---------------------------------------------------------------

%a=mmreadgray('../Data/blob2.tif');
%b=mmcbisector(a,mmsebox(),1);
%c=mmcbisector(a,mmsebox(),3);
%d=mmcbisector(a,mmsebox(),10);

%subplot(2,2,1); mmshow(a,b)
%subplot(2,2,2); mmshow(a,c)
%subplot(2,2,3); mmshow(a,d)

%---------------------------------------------------------------
%   mmseshow
%---------------------------------------------------------------

%b=mmsecross(3);
%mmseshow(b)

%a = mmseshow(b,'EXPAND')
%mmshow(a)

%mmseshow(b,'NON-FLAT')

%b=mmsedisk(2,'2D','EUCLIDEAN','NON-FLAT')
%mmseshow(b)

%---------------------------------------------------------------
%   mmimg2se
%---------------------------------------------------------------

%a = mmimg2se(mmbinary([
%  [0,1,0];
%  [1,1,1];
%  [0,1,0]]))
%mmseshow(a)

%b = mmbinary([
%  [0,1,1,1];
%  [1,1,1,0]])
%b1 = mmimg2se(b)
%mmseshow(b1)

%c = mmbinary([
%  [0,1,0];
%  [1,1,1];
%  [0,1,0]])
%d = int32([
%  [0,0,0];
%  [0,1,0];
%  [0,0,0]])
%e = mmimg2se(c,'NON-FLAT',d)        TODO
%mmseshow(e)

%---------------------------------------------------------------
%   mmdist
%---------------------------------------------------------------

%a = mmframe(mmbinary(ones(5,9)),2,4)
%f4=mmdist(a)
%f8=mmdist(a,mmsebox())
%fe=mmdist(a,mmsebox(),'EUCLIDEAN')

%---------------------------------------------------------------
%   mmgdist
%---------------------------------------------------------------

%f=mmbinary([
% [1,1,1,1,1,1],
% [1,1,1,0,0,1],
% [1,0,1,0,0,1],
% [1,0,1,1,0,0],
% [0,0,1,1,1,1],
% [0,0,0,1,1,1]])
%g=mmbinary([
% [0,0,0,0,0,0],
% [1,1,0,0,0,0],
% [0,0,0,0,0,0],
% [0,0,0,0,0,0],
% [0,0,0,0,0,0],
% [0,0,0,0,0,1]])
%%% y=mmgdist(f,g,mmsecross())      TODO

%f=mmreadgray('../Data/maze_bw.tif');
%g=mmintersec(f,0);
%g=mmdrawv(g,uint16([[2],[2],[6],[6]]),uint16(1),'filledrect');
%y=mmgdist(f,g,mmsebox(),'EUCLIDEAN');

%subplot(1,2,1); mmshow(f,g)
%subplot(1,2,2); mmdtshow(y,200)

%---------------------------------------------------------------
%   mmblob
%---------------------------------------------------------------

%fr=uint8([
%   [1,1,1,0,0,0],
%   [1,1,1,0,0,2],
%   [1,1,1,0,2,2]])
%f_area=mmblob(fr,'area')
%f_cent=mmblob(fr,'centroid')
%f_bb=mmblob(fr,'boundingbox')

%d_area=mmblob(fr,'area','data')
%d_cent=mmblob(fr,'centroid','data')
%d_bb=mmblob(fr,'boundingbox','data')

%---------------------------------------------------------------
%  mmlabel
%---------------------------------------------------------------

%f=mmbinary([
%   [0,1,0,1,1],
%   [1,0,0,1,0]])
%g=mmlabel(f)

%f = mmreadgray('../Data/blob3.tif');
%g = mmlabel(f);
%nblobs=mmstats(g,'max')

%h = mmlblshow(g);
%subplot(1,2,1); mmshow(f)
%subplot(1,2,2); imshow(uint8(h))

%---------------------------------------------------------------
%  mmgrain
%---------------------------------------------------------------

%f = [0:5;0:5;0:5]
%fr = ([
%   [1,2,3,4,5,6],
%   [1,2,3,4,5,6],
%   [1,2,3,4,5,6]])

%mmgrain(fr,f,'sum','data')
%mmgrain(fr,f,'sum')

%---------------------------------------------------------------
%  mmlabelflat
%---------------------------------------------------------------

%f=uint8([
%   [5,5,8,3,0],
%   [5,8,8,0,2]])
%g=mmlabelflat(f)
%%%g1=mmlabelflat(f,mmsecross(),2)

%---------------------------------------------------------------
%   mmopentransf
%---------------------------------------------------------------

%f = mmbinary([
%              [0,0,0,0,0,0,0,0],
%              [0,0,1,1,1,1,0,0],
%              [0,0,1,1,1,1,1,0],
%              [0,1,0,1,1,1,0,0],
%              [1,1,0,0,0,0,0,0]])

%mmopentransf( f, 'city-block')
%mmopentransf( f, 'linear-h')
%mmopentransf( f, 'linear-45r')
%mmopentransf( f, 'user',10,mmsecross(),mmbinary([0,1,1]))
%mmopentransf( f, 'city-block-rec')

%f=mmreadgray('../Data/numbers.tif');
%g=mmopentransf(f,'OCTAGON');
%gp = uint8(255*double(g)/max(max(g)));    % Normalisation

%subplot(1,2,1); mmshow(f)
%subplot(1,2,2); mmshow(gp)

%b=mmsedisk(3,'OCTAGON');
%g1=mmopen(f,b);
%mmshow(g1)
%g2=mmcmp(g,'>',3);
%mmis(g1,'==',g2)

%---------------------------------------------------------------
%    mmcero
%---------------------------------------------------------------

%f = mmneg(mmtext('hello'));
%g = mmdil(f,mmseline(7,90));
%a1=mmcero(g,f,mmsebox());
%a13=mmcero(a1,f,mmsebox(),13);

%subplot(1,4,1); mmshow(f)
%subplot(1,4,2); mmshow(g)
%subplot(1,4,3); mmshow(a1)
%subplot(1,4,4); mmshow(a13)

%---------------------------------------------------------------
%   mmcwatershed
%---------------------------------------------------------------

%a = uint8([
%    [10,   10,   10,   10,   10,   10,   10],
%    [10,    9,    6,   18,    6,    5,   10],
%    [10,    9,    6,   18,    6,    8,   10],
%    [10,    9,    9,   15,    9,    9,   10],
%    [10,    9,    9,   15,   12,   10,   10],
%    [10,   10,   10,   10,   10,   10,   10]])
%b = mmcmp(a,'==',uint8(6))
%mmcwatershed(a,b)
%mmcwatershed(a,b,mmsecross(),'REGIONS')

%f=mmreadgray('../Data/astablet.tif');
%f = f(1:floor(end/2),1:floor(end/2));
%f = f(1:16,1:16);
%grad=mmgradm(f);
%mark=mmregmin(mmhmin(grad,17));
%w=mmcwatershed(grad,mark);

%subplot(2,2,1); mmshow(uint8(grad))
%subplot(2,2,2); mmshow(mark)
%ubplot(2,2,3); mmshow(w)

%---------------------------------------------------------------
%   mmwatershed
%---------------------------------------------------------------

%f=mmreadgray('../Data/astablet.tif');
%grad=mmgradm(f);
%w1=mmwatershed(grad,mmsebox());
%w2=mmwatershed(grad,mmsebox(),'REGIONS');

%h = mmlblshow(w2);
%subplot(2,2,1); mmshow(grad)
%subplot(2,2,2); mmshow(w1)
%subplot(2,2,3); imshow(uint8(h))

%---------------------------------------------------------------
%   mmskiz
%---------------------------------------------------------------

f=mmreadgray('../Data/blob2.tif');
y=mmskiz(f,mmsebox(),'LINES','EUCLIDEAN');
mmshow(f,y)

f=mmbinary(zeros(100,100));
f(30,25) = 1;
f(20,75) = 1;
f(50,50) = 1;
f(70,30) = 1;
f(80,70) = 1;
y = mmskiz(f,mmsebox(),'LINES','EUCLIDEAN');
mmshow(f,y)
