function MBEntityArray = encodePicSlice(pic, picType, qScale)
%Ari8mos twn Mblocks diastasewn 16x16
numOfMB = size(pic.decPic.frameY,1)*size(pic.decPic.frameY,2)/256; %=396
%Ekthpwsh ths proodou ths diadikasia,apla gia optiko elegxo
fprintf('Frame encoding(');

for mBIndex=1:numOfMB %=396
Header = genMBHeader(picType,qScale);    
MBEntityArray{mBIndex}.MBHeader = writeMBHeader(Header);

[mVect ,blockArray ] = encodeMB(pic, picType, qScale, mBIndex);

MBEntityArray{mBIndex}.MotionVetors = mVect;
MBEntityArray{mBIndex}.BlockEntityArray = blockArray;
    
    %Ekthpwsh proodou
    if(mod(mBIndex,10)==0)
    fprintf('.');
    end
end
fprintf(')\n');
end