function [mBY, mBCr, mBCb] = iMotEstB(eMBY, eMBCr, eMBCb, mBIndex, mV, ...
                                      backwFrameY, backwFrameCr, backwFrameCb, ...
                                      forwFrameY, forwFrameCr, forwFrameCb)

eMBY=double(eMBY);
eMBCr=double(eMBCr); 
eMBCb=double(eMBCb); 
backwFrameY=double(backwFrameY);
backwFrameCr=double(backwFrameCr); 
backwFrameCb=double(backwFrameCb);                                   
forwFrameY=double(forwFrameY);
forwFrameCr=double(forwFrameCr); 
forwFrameCb=double(forwFrameCb);                                      
                                  
%Mege8os MacroBlock
StepMBlock16=16;
StepMBlock8=8;

%Suntetagmenes 18x22 tou trexontos block B-frame frameY
dl=length(backwFrameY(1,:))/StepMBlock16; %di=22
dw=length(backwFrameY(:,1))/StepMBlock16; %di=18
if mBIndex>dl*dw
fprintf('\n Error:Too large mBIndex\n \n')
return
end
x_P=ceil(mBIndex/dl);
y_P=mBIndex-(x_P-1)*dl; 
%Metatroph se syntetagmenes eikonas 288x352
xFr=(x_P-1)*StepMBlock16+1;
yFr=(y_P-1)*StepMBlock16+1;
%%
%Backward
refFrameY = backwFrameY;
refFrameCr = backwFrameCr;
refFrameCb = backwFrameCb;
%Sunteragmenes toy refFrameY
xm=int16(xFr-mV(1,1));
ym=int16(yFr-mV(2,1));

MtY_backw=refFrameY(xm:xm+StepMBlock16-1,ym:ym+StepMBlock16-1);

%Ypologismos Cr Cb suntetagmenwn
xRef_CbCr =int16((xm-1)/2+1);
yRef_CbCr =int16((ym-1)/2+1);
MtCr_backw = refFrameCr(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);
MtCb_backw = refFrameCb(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);
%%
%Forward
refFrameY = forwFrameY;
refFrameCr = forwFrameCr;
refFrameCb = forwFrameCb;
%Sunteragmenes toy refFrameY
xm=int16(xFr-mV(1,2));
ym=int16(yFr-mV(2,2));

MtY_forw=refFrameY(xm:xm+StepMBlock16-1,ym:ym+StepMBlock16-1);

%Ypologismos Cr Cb suntetagmenwn
xRef_CbCr =int16((xm-1)/2+1);
yRef_CbCr =int16((ym-1)/2+1);
MtCr_forw = refFrameCr(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);
MtCb_forw = refFrameCb(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);

%
mBY=eMBY + (MtY_forw+MtY_backw)./2;
mBCr=eMBCr + (MtCr_forw+MtCr_backw)./2;
mBCb=eMBCb + (MtCb_forw+MtCb_backw)./2;

end 
