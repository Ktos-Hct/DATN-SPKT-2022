function decodeMPEG(fName, outFName)

%Add the 'Step1' folders to the top of the search path
%so that we can use the previous functions from folder Step1
addpath(genpath('../../Step1'));
addpath(genpath('../'));

load(fName);
decodeSeq(SeqEntity.GoPEntityArray, outFName);

%rmpath(genpath('../'));
rmpath(genpath('../../Step1'));

end