function GoPEntityArray = encodeSeq(bName, fExtension, startFrame, GoP, numOfGoPs, qScale)

GoPsNum=0;
GoPEntityArray{1}.GoPHeader = 'Empty';
GoPEntityArray{1}.PicSliceEntityArray = 'Empty';
%Số khung hình của GoP
pics_Per_GoP=length(GoP');
while true
frameNumber = pics_Per_GoP*GoPsNum;
GoPsNum=GoPsNum+1;
[t, PicSliceEntityArray] = encodeGoP(frameNumber, bName, fExtension,startFrame, GoP, qScale);

%Dhmiourgia twn GoPEntity
Header = genGoPHeader();
GoPEntityArray{GoPsNum}.GoPHeader = writeGoPHeader(Header);
GoPEntityArray{GoPsNum}.PicSliceEntityArray = PicSliceEntityArray;

%An teleiwsoun oi eikones h an paroume ton
%ka8orismeno ari8mo apo GoPs tote telos
if (t==0)||(numOfGoPs==GoPsNum)
 break;
end

end

end