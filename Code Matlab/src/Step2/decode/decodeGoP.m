function decodeGoP(PicSliceEntityArray, outFName)

numOfPicsPerGoP = length(PicSliceEntityArray);
%dhmiourgia buffer
createBuffer();

for indx=1:numOfPicsPerGoP
 
 pic = decodePicSlice(PicSliceEntityArray{indx}.MBEntityArray);    
 tempRef = PicSliceEntityArray{indx}.PicSliceHeader.temporal_reference;
 picType = PicSliceEntityArray{indx}.PicSliceHeader.picture_coding_type;
 
 %Apo8hkeysh eikonas
 pushFlushPic(pic, tempRef, outFName)
 
 if (picType==1 || picType==2)
 pushPic(pic);
 end
end

end