function [eMBY, eMBCr, eMBCb, mV] = motEstB(frameY, frameCr, frameCb, mBIndex, ...
                                            backwFrameY, backwFrameCr, backwFrameCb, ...
                                            forwFrameY, forwFrameCr, forwFrameCb)
                                                                                
frameY=double(frameY);
frameCr=double(frameCr); 
frameCb=double(frameCb); 
backwFrameY=double(backwFrameY);
backwFrameCr=double(backwFrameCr); 
backwFrameCb=double(backwFrameCb); 
forwFrameY=double(forwFrameY);
forwFrameCr=double(forwFrameCr); 
forwFrameCb=double(forwFrameCb);

%Mege8os MacroBlock
StepMBlock16=16;
StepMBlock8=8;
Y_max = size(frameY,2);
X_max = size(frameY,1);

dl=Y_max/StepMBlock16; %di=22
dw=X_max/StepMBlock16; %di=18


if mBIndex>dl*dw
warning('\n Error:Too large mBIndex\n \n')
return
end

%Suntatagmenes 18x22 tou trexontos block B-frame frameY
%Grammh
x_P=ceil(mBIndex/dl);
%Steilh
y_P=mBIndex-(x_P-1)*dl;

%Metatroph se syntetagmenes eikonas 288x352
xFr=(x_P-1)*StepMBlock16+1;
yFr=(y_P-1)*StepMBlock16+1;

%Ypologismos Cr Cb suntetagmenwn
xP_CbCr=int16((xFr-1)/2+1);
yP_CbCr=int16((yFr-1)/2+1);
%%
%Backward Motion Estimation
refFrameY = backwFrameY;
refFrameCr = backwFrameCr;
refFrameCb = backwFrameCb;

%Ektimish Kinhshs
w = 7;
%Search window (2w by 2w area) 
%Orizoyme mia perioxh gyro apo to block,diastaseis (2w by 2w) se pels 
xWmin = xFr-w; 
xWmax = xFr+w;
yWmin = yFr-w;
yWmax = yFr+w;
%Megista epitrepta oria eikonas 
X_max = X_max-StepMBlock16+1;
Y_max = Y_max-StepMBlock16+1;
%Elegxos sta akra tis eikonas na mhn bgoume ektos eikonas
if xWmin<1 ; xWmin=1; end;
if xWmax>X_max ; xWmax=X_max; end;
if yWmin<1 ; yWmin=1; end;
if yWmax>Y_max ; yWmax=Y_max; end;

min_Ind=realmax('double');
for xRef=xWmin:xWmax   
for yRef=yWmin:yWmax 
    %Ypologismos omoiothtas me SSD(Sum of Squared Differences) or Mean of squarred error (MSE)
    dif=frameY(xFr:xFr+StepMBlock16-1,yFr:yFr+StepMBlock16-1) - ...
        refFrameY(xRef:xRef+StepMBlock16-1,yRef:yRef+StepMBlock16-1);
    ssd=sum(sum(dif.^2));

    if ssd<=min_Ind
    min_Ind=ssd;
    xm = xRef;
    ym = yRef;
    end
end
end

%Motion vector
mV=[xFr-xm 0;yFr-ym 0];

%Ypologismos Cr Cb suntetagmenwn se pels
xRef_CbCr=int16((xm-1)/2+1);
yRef_CbCr=int16((ym-1)/2+1);

MtY_backw = refFrameY(xm:xm+StepMBlock16-1,ym:ym+StepMBlock16-1);
MtCr_backw = refFrameCr(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);
MtCb_backw = refFrameCb(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);                                       
                                        
%%
%Forward Motion Estimation
refFrameY=forwFrameY;
refFrameCr = forwFrameCr;
refFrameCb = forwFrameCb;

%Ektimish Kinhshs
%Search window (2w by 2w area) 
%Orizoyme mia perioxh gyro apo to block,diastaseis (2w by 2w) se pels 
xWmin = xFr-w; 
xWmax = xFr+w;
yWmin = yFr-w;
yWmax = yFr+w;

%Elegxos sta akra tis eikonas na mhn bgoume ektos eikonas
if xWmin<1 ; xWmin=1; end;
if xWmax>X_max ; xWmax=X_max; end;
if yWmin<1 ; yWmin=1; end;
if yWmax>Y_max ; yWmax=Y_max; end;

min_Ind=realmax('double');
for xRef=xWmin:xWmax   
for yRef=yWmin:yWmax 
    
    %Ypologismos omoiothtas me SSD(Sum of Squared Differences)
    dif=frameY(xFr:xFr+StepMBlock16-1,yFr:yFr+StepMBlock16-1) - ...
        refFrameY(xRef:xRef+StepMBlock16-1,yRef:yRef+StepMBlock16-1);
    ssd=sum(sum(dif.^2));

    if ssd<=min_Ind
        min_Ind=ssd;
        xm = xRef;
        ym = yRef;
    end
end
end

%Ypologismos Cr Cb suntetagmenwn
xRef_CbCr=int16((xm-1)/2+1);
yRef_CbCr=int16((ym-1)/2+1);

%Motion vector
mV(:,2)=[xFr-xm ; yFr-ym];

MtY_forw = refFrameY(xm:xm+StepMBlock16-1,ym:ym+StepMBlock16-1);
MtCr_forw = refFrameCr(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);
MtCb_forw = refFrameCb(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);                                           
                                        
%%
%Sfalma problepshs
eMBY=frameY(xFr:xFr+StepMBlock16-1,yFr:yFr+StepMBlock16-1)-(MtY_backw+MtY_forw)./2;

eMBCr=frameCr(xP_CbCr:xP_CbCr+StepMBlock8-1,yP_CbCr:yP_CbCr+StepMBlock8-1)-(MtCr_backw+MtCr_forw)./2;

eMBCb=frameCb(xP_CbCr:xP_CbCr+StepMBlock8-1,yP_CbCr:yP_CbCr+StepMBlock8-1)-(MtCb_backw+MtCb_forw)./2;
end                                       