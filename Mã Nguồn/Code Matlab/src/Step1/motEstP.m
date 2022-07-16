function [eMBY, eMBCr, eMBCb, mV] = motEstP(frameY, frameCr, frameCb, mBIndex, ...
                                             refFrameY, refFrameCr, refFrameCb)
frameY=double(frameY);
frameCr=double(frameCr); 
frameCb=double(frameCb); 
refFrameY=double(refFrameY);
refFrameCr=double(refFrameCr); 
refFrameCb=double(refFrameCb);
%Chuyển sang độ chính xác gấp đôi

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
%Tọa độ 18x22 của block P-frame frameY
%Grammh
x_P=ceil(mBIndex/dl);
%Steilh
y_P=mBIndex-(x_P-1)*dl;
 
%Chuyển đổi sang tọa độ hình ảnh 288x352
xFr=(x_P-1)*StepMBlock16+1;
yFr=(y_P-1)*StepMBlock16+1;
%%
%Ước tính lưu lượng truy cập
w = 7;
%Search window (2w by 2w area) 
%Chúng tôi xác định một khu vực xung quanh khối, các kích thước (2w by 2w)nếu bởi 
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
%%
%Motion vector
mV=[xFr-xm NaN;yFr-ym NaN];

%Ypologismos Cr Cb suntetagmenwn
xP_CbCr=int16((xFr-1)/2+1);
yP_CbCr=int16((yFr-1)/2+1);
xRef_CbCr=int16((xm-1)/2+1);
yRef_CbCr=int16((ym-1)/2+1);

%Sfalma problepshs
eMBY=frameY(xFr:xFr+StepMBlock16-1,yFr:yFr+StepMBlock16-1) - ...
     refFrameY(xm:xm+StepMBlock16-1,ym:ym+StepMBlock16-1);

eMBCr=frameCr(xP_CbCr:xP_CbCr+StepMBlock8-1,yP_CbCr:yP_CbCr+StepMBlock8-1) - ...
     refFrameCr(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);

eMBCb=frameCb(xP_CbCr:xP_CbCr+StepMBlock8-1,yP_CbCr:yP_CbCr+StepMBlock8-1) - ...
     refFrameCb(xRef_CbCr:xRef_CbCr+StepMBlock8-1,yRef_CbCr:yRef_CbCr+StepMBlock8-1);

end