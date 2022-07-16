function decodeSeq(GoPEntityArray, outFName)

NumOfGoPs = length(GoPEntityArray);

for indx=1:NumOfGoPs
decodeGoP(GoPEntityArray{indx}.PicSliceEntityArray, outFName);
end

end