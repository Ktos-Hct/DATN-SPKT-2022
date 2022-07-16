function [vlcStream] = vlc(runSymbols)

global d15a;
global d15b;
global d16b;
global d17b;
if(size(d15a,1)==0)
getTheGlobals;
end
R=size(runSymbols,1);
vlcArray = cell(R,1);

for iCell=1:R
run = runSymbols(iCell,1);
level = runSymbols(iCell,2);
index=0;

%Psa3e prwta stous pinakes d15
for j=1:size(d15a,1)
 if ((run==d15a(j,1))&&(abs(level)==d15a(j,2)))
  index=j;
  break;
 end
end

%An uparxei ston pikana d15a
if (index~=0)
  if(level>0) %Positive level s=0   
   vlcArray{iCell} = strcat(d15b{index},'0');
  else        %Negative level s=1
   vlcArray{iCell} = strcat(d15b{index},'1');
  end
  
%An den uparxei ston pikana d15a tote kwdikopoioume me tous d16,d17
else
 %Deikths pinaka d17b    
 %Negative level     
 indexD17b=256+level; 
 %Positive level
  if(level>0)   
  indexD17b = 255+level;
  end
 escapeBin = '000001';
 runBin = d16b{run+1}; 
 levelBin = d17b{indexD17b};
 vlcArray{iCell} = strcat(escapeBin,runBin,levelBin);
end

end

vlcStream=vlcArray{1};
for i=2:R
vlcStream = [vlcStream vlcArray{i}];
end
%Bits telous block
vlcStream = strcat(vlcStream,'10');
end