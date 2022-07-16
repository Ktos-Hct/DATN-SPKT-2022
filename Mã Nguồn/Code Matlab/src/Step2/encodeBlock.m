function VLCodes = encodeBlock(blockMatrix,mBType,qScale)

dctBlock = blockDCT(blockMatrix);

global intra_qTable;
global non_intra_qTable;

if size(intra_qTable,1)==0
%Figure 2-D.15 Default intra quantization matrix
intra_qTable = ...
[8 16 19 22 26 27 29 34;
 16 16 22 24 27 29 34 37;
 19 22 26 27 29 34 34 38;
 22 22 26 27 29 34 37 40;
 22 26 27 29 32 35 40 48;
 26 27 29 32 35 40 48 58;
 26 27 29 34 38 46 56 69;
 27 29 35 38 46 56 69 83];

%Figure 2-D.16 Default non-intra quantization matrix
non_intra_qTable = ...
[16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16;
 16 16 16 16 16 16 16 16];
end

if mBType==1 %<--I type
 qBlock = quantizeI(dctBlock, intra_qTable, qScale);
else %<--P B type
 qBlock = quantizePB(dctBlock, non_intra_qTable, qScale);    
end

runSymbols = runLength(qBlock);
VLCodes = vlc(runSymbols);

end