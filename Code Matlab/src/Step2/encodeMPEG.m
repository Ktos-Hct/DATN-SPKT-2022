function encodeMPEG(bName, fExtension,startFrame,GoP, numOfGoPs, qScale)

if qScale<1||qScale>31
   warning('"qScale" có bất kỳ giá trị nào từ 1 đến 31 bao gồm\n');
   return;
end

%//them mot so thu vien o step1 và images
addpath(genpath('../Step1'));
addpath(genpath('../images'));

  %Paragwgh headers
Headers = genSeqHeader();%tiêu chuẩn ISO/IEC 13818-2
  %Ergrafh tou SeqHeader
SeqEntity.SeqHeader = writeSeqHeader(Headers);
SeqEntity.GoPEntityArray = encodeSeq(bName, fExtension, startFrame, GoP, numOfGoPs, qScale);
  %Egrafh tou SeqEnd
SeqEntity.SeqEnd = writeSeqEnd(Headers);

save('Stream','SeqEntity');

%Remove the paths
rmpath(genpath('../images'));
rmpath(genpath('../Step1'));

end

