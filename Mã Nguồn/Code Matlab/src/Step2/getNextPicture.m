function [pic, picType, tempRef] = getNextPicture(bName, fExtension, frameNumber, ...
                                                  startFrame, GoP)
%Number of frames per GoP
pics_Per_GoP=length(GoP');
%To n-osto frame tou trexodos GOP
N_Frame = mod(frameNumber,pics_Per_GoP)+1;
startFrameGoP = frameNumber-N_Frame;
index=N_Frame;
%%
%Codes:1,2,3->I,P,B,in order to rememder them :)

if (strcmp(GoP(N_Frame),'I'))                    %<----I-frame
picType = 1;
 if(N_Frame~=1) %An to GOP kleinei me I tote to exoume parei apo prin opote
  if strcmp(GoP(N_Frame-1),'B') %an to prohgoumeno tou einai B
   index = N_Frame-1 ; %tote pare to prohgoumeno frame B
   picType = 3;
  end
 end
 
elseif (strcmp(GoP(N_Frame),'B')) %An einai B kai %<----B-frame
picType = 3;    
 if(strcmp(GoP(N_Frame-1),'I')||(strcmp(GoP(N_Frame-1),'P'))) %to prohgoumeno I h P
   i=1;                                   %tote spa3e gia to epomeno I h P
   while (~(strcmp(GoP(N_Frame+i),'I')||(strcmp(GoP(N_Frame+i),'P'))))
   i=i+1;
   end
   picType = 1; 
   if (strcmp(GoP(N_Frame+i),'P') ); picType = 2; end;
   index = N_Frame+i ; %pare to epomeno I h P frame
 else %An to prohgoume einai B 
  index = N_Frame-1; %pare to prohgoume
 end
 
else %Einai telika P frame kai                    %<----P-frame
picType = 2;    
 if(strcmp(GoP(N_Frame-1),'B')) %to prohgoume einai B 
  index = N_Frame-1; %pare to prohgoume frame
  picType = 3; 
 end  
end
%%
%Ari8mos sto onoma ths eikonas
picFrameNum = startFrameGoP + index + startFrame;
%Onoma ths eikonas
picName = strcat(bName,num2str(picFrameNum),'.',fExtension);

%An den uparxei h eikona tote stamatame
if exist(picName,'file')==0
 pic=0;
 picType=0;
 tempRef=-1;
 return
end

tempRef = startFrameGoP + index;
frameRGB = imread(picName);
[pic.decPic.frameY, pic.decPic.frameCr, pic.decPic.frameCb] = ccir2ycrcb(frameRGB);


end
