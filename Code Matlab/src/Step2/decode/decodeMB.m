function [decMBY,decMBCr,decMBCb] = decodeMB(BlockEntityArray, MotionVectors, ...
                                             mBType, mBIndex, qScale)
if (mBType==2||mBType==3)
mV = MotionVectors; 
end

StepMBlock16 = 16;
StepMBlock8 = 8;

eMBY = uint8(zeros(StepMBlock16,StepMBlock16));

%4 Y block and 1 Cr and 1 Cb
eMBY(1:8,1:8) = decodeBlock(BlockEntityArray{1},mBType,qScale);
eMBY(1:8,9:16)= decodeBlock(BlockEntityArray{2},mBType,qScale);
eMBY(9:16,1:8)= decodeBlock(BlockEntityArray{3},mBType,qScale);
eMBY(9:16,9:16)= decodeBlock(BlockEntityArray{4},mBType,qScale);
eMBCr = decodeBlock(BlockEntityArray{5},mBType,qScale);
eMBCb = decodeBlock(BlockEntityArray{6},mBType,qScale);

switch mBType
  case 2 %<---P type
  refFrame = readBuffer(1);
  [decMBY, decMBCr, decMBCb] = iMotEstP(eMBY, eMBCr, eMBCb, mBIndex, mV, ...
                refFrame.decPic.frameY,refFrame.decPic.frameCr, refFrame.decPic.frameCb);
   
  case 3 %<---B type
   backWFrame = readBuffer(2);
   forWFrame = readBuffer(1);
   [decMBY, decMBCr, decMBCb] = iMotEstB(eMBY, eMBCr, eMBCb, mBIndex, mV, ...
                backWFrame.decPic.frameY,backWFrame.decPic.frameCr, backWFrame.decPic.frameCb, ...
                forWFrame.decPic.frameY,forWFrame.decPic.frameCr, forWFrame.decPic.frameCb);    
   
   otherwise %<---I type
   %Pernoume to I block auto ka8auto  
   decMBY = eMBY;
   decMBCr = eMBCr;
   decMBCb = eMBCb;
end

end