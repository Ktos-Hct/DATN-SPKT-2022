function [MotionVectors, BlockEntityArray] = encodeMB(pic, picType, qScale, mBIndex)

StepMBlock16 = 16;
StepMBlock8 = 8;

switch picType
  case 2 %<---P type
  refFrame = readBuffer(1);
  [eMBY, eMBCr, eMBCb, mV] = motEstP(pic.decPic.frameY,pic.decPic.frameCr, pic.decPic.frameCb, mBIndex, ...
                refFrame.decPic.frameY,refFrame.decPic.frameCr, refFrame.decPic.frameCb);
   %encodeMV()
  case 3 %<---B type
   backWFrame = readBuffer(2);
   forWFrame = readBuffer(1);
  [eMBY, eMBCr, eMBCb, mV] = motEstB(pic.decPic.frameY,pic.decPic.frameCr, pic.decPic.frameCb, mBIndex, ...
                backWFrame.decPic.frameY,backWFrame.decPic.frameCr, backWFrame.decPic.frameCb, ...
                forWFrame.decPic.frameY,forWFrame.decPic.frameCr, forWFrame.decPic.frameCb);    
   %encodeMV()
   otherwise %<---I type
   %Suntetagmenes tou MBlock se pixels
   [xY ,yY ,x_CrCb, y_CrCb] = returnCord(pic.decPic.frameY,mBIndex);   
   
   %Pernoume to I block auto ka8auto     
   eMBY = pic.decPic.frameY(xY:xY+StepMBlock16-1,yY:yY+StepMBlock16-1);
   eMBCr = pic.decPic.frameCr(x_CrCb:x_CrCb+StepMBlock8-1,y_CrCb:y_CrCb+StepMBlock8-1);
   eMBCb = pic.decPic.frameCb(x_CrCb:x_CrCb+StepMBlock8-1,y_CrCb:y_CrCb+StepMBlock8-1);   

   mV = [NaN NaN;NaN NaN];
end

MotionVectors = mV;
%4 Y block and 1 Cr and 1 Cb
BlockEntityArray{1}.VLCodes = encodeBlock(eMBY(1:8,1:8),picType,qScale);
BlockEntityArray{2}.VLCodes = encodeBlock(eMBY(1:8,9:16),picType,qScale);
BlockEntityArray{3}.VLCodes = encodeBlock(eMBY(9:16,1:8),picType,qScale);
BlockEntityArray{4}.VLCodes = encodeBlock(eMBY(9:16,9:16),picType,qScale);
BlockEntityArray{5}.VLCodes = encodeBlock(eMBCr,picType,qScale);
BlockEntityArray{6}.VLCodes = encodeBlock(eMBCb,picType,qScale);
end