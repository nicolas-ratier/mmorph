function y = mmframe(f,WT,HT,DT,k1,k2)

Limit = mmlimits(f);
if nargin < 6, k2 = Limit(1); end
if nargin < 5, k1 = Limit(2); end
if nargin < 4, DT = 0;   end         % 3D uniquement (not supported)
if nargin < 3, HT = 1;   end
if nargin < 2, WT = 1;   end

    %%% assert len(f.shape) < 3,'Supports 2D only'
    y = mmunion(mmintersec(f,Limit(1)),k2);
    y(:,1:WT      ) = k1;
    y(:,end-WT+1:end) = k1;
    y(1:HT,:      ) = k1;
    y(end-HT+1:end,:) = k1;