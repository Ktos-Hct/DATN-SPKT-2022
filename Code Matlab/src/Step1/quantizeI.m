function [qBlock] = quantizeI(dctBlock, qTable, qScale)
dctBlock = double(dctBlock);
qTable = double(qTable);
qScale = double(qScale);
%Gia ta I-blocks o kvantismos twn DC orwn diaferei twn AC orwn
%Dieroume me sta8ero bhma=8 tous DC orous gia luminance and chrominance components

qStepDC=8;
DC = dctBlock(1,1);

qBlock = round(8*dctBlock./(qScale*qTable));
%Gia ton DC oro
qBlock(1,1) = round(DC/qStepDC);

end

