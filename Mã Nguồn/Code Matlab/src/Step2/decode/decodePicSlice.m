function pic = decodePicSlice(MBEntityArray)

numOfMB = length(MBEntityArray);
StepMBlock16 = 16;
StepMBlock8 = 8;
pic.decPic.frameY = uint8(zeros(288,352));
pic.decPic.frameCr = uint8(zeros(144,176));
pic.decPic.frameCb = uint8(zeros(144,176));

%Ekthpwsh ths proodou ths diadikasia,apla gia optiko elegxo
fprintf('Frame decoding(');

for mBIndex=1:numOfMB
 mBType = MBEntityArray{mBIndex}.MBHeader.macroblock_type ;
 qScale = MBEntityArray{mBIndex}.MBHeader.quantizer_scale ;
 mV = MBEntityArray{mBIndex}.MotionVetors ;
 BlockEntityArray = MBEntityArray{mBIndex}.BlockEntityArray;

 [decMBY,decMBCr,decMBCb] = decodeMB(BlockEntityArray, mV, ...
                                    mBType, mBIndex, qScale) ;
 
 %Suntetagmenes tou MBlock se pixels
 [xY ,yY ,x_CrCb, y_CrCb] = returnCord(pic.decPic.frameY,mBIndex);   
 
 %Pernoume to I block auto ka8auto     
 pic.decPic.frameY(xY:xY+StepMBlock16-1,yY:yY+StepMBlock16-1) = decMBY;
 pic.decPic.frameCr(x_CrCb:x_CrCb+StepMBlock8-1,y_CrCb:y_CrCb+StepMBlock8-1) = decMBCr;
 pic.decPic.frameCb(x_CrCb:x_CrCb+StepMBlock8-1,y_CrCb:y_CrCb+StepMBlock8-1) = decMBCb;                                 
 
 %Ekthpwsh proodou
    if(mod(mBIndex,10)==0)
    fprintf('.');
    end
end
fprintf(')\n');
end