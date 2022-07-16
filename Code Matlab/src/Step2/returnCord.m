function [xY,yY,xCrCb,yCrCb] = returnCord(frameY,mBIndex)
%H sunarthsh metatrepei ton au3onta ari8mo tou MacroBlock
%se suntetagmenes eikonas (pixels) gia ta Y,Cr kai Cb poy
%antistoixoyn to panw aristera pixel tou ka8e block
%xY,xCrCb: vertical
%yY,yCrCb: horizontal

%Mege8os MacroBlock
StepMBlock16=16;

dl=length(frameY(1,:))/StepMBlock16; %di=22
dw=length(frameY(:,1))/StepMBlock16; %di=18

if mBIndex>dl*dw
warning('\n Error:Too large mBIndex\n \n')
return
end

%Suntatagmenes 18x22 tou trexontos Macroblock frameY
%Grammh
x_P=ceil(mBIndex/dl);
%Steilh
y_P=mBIndex-(x_P-1)*dl;
 
%Metatroph se syntetagmenes eikonas 288x352
xY=(x_P-1)*StepMBlock16+1;
yY=(y_P-1)*StepMBlock16+1;

%Ypologismos Cr Cb suntetagmenwn
xCrCb =(xY-1)/2+1;
yCrCb =(yY-1)/2+1;

end