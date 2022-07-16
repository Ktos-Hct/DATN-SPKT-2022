function [mBY, mBCr, mBCb] = iMotEstP(eMBY, eMBCr, eMBCb, mBIndex, mV, ...
                                      refFrameY, refFrameCr, refFrameCb)
eMBY=double(eMBY);
eMBCr=double(eMBCr); 
eMBCb=double(eMBCb); 
refFrameY=double(refFrameY);
refFrameCr=double(refFrameCr); 
refFrameCb=double(refFrameCb); 
                                                                  
%Mege8os MacroBlock
StepMBlock16=16;
StepMBlock8=8;

%Suntatagmenes 18x22 tou trexontos block P-frame frameY
dl=length(refFrameY(1,:))/StepMBlock16; %di=22
%dw=length(refFrameY(:,1))/StepMBlock16; %di=18                                                                    
x_P=ceil(mBIndex/dl);
y_P=mBIndex-(x_P-1)*dl; 
%Metatroph se syntetagmenes eikonas 288x352
xFr=(x_P-1)*StepMBlock16+1;
yFr=(y_P-1)*StepMBlock16+1;

%Sunteragmenes toy refFrameY
xm=int16(xFr-mV(1,1));
ym=int16(yFr-mV(2,1));

mBY=eMBY + refFrameY(xm:xm+StepMBlock16-1,ym:ym+StepMBlock16-1);

%Ypologismos Cr Cb suntetagmenwn
xRef_CbCr=int16((xm-1)/2+1);
yRef_CbCr=int16((ym-1)/2+1);

mBCr=eMBCr + refFrameCr(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);
mBCb=eMBCb + refFrameCb(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);

end