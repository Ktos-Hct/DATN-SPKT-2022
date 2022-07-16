function [t, PicSliceEntityArray] = encodeGoP(frameNumber, bName, fExtension,...
                                             startFrame, GoP, qScale)
%dhmiourgia buffer
createBuffer();
%Arxikopoihsh metablhtwn
t=1;
PicSliceEntityArray{1}.PicSliceHeader = 'Empty';
PicSliceEntityArray{1}.MBEntityArray = 'Empty';
%Number of frames per GoP
pics_Per_GoP=length(GoP');

for i=1:pics_Per_GoP

 [pic, picType, tempRef] = getNextPicture(bName, fExtension, frameNumber+i-1, ...
                                                  startFrame, GoP);                                                                                            
 %Apotyxia anagnwshs eikonas
 if (tempRef==-1)                           
  t=0;
 break;
 end
 Header = genPicSliceHeader(tempRef,picType,qScale);
 PicSliceEntityArray{i}.PicSliceHeader = writePicSliceHeader(Header);
 PicSliceEntityArray{i}.MBEntityArray = encodePicSlice(pic, picType, qScale); 

 if (picType==1 || picType==2)
 pushPic(pic);
 end

end

end