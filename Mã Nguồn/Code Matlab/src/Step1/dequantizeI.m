function [dctBlock] = dequantizeI(qBlock, qTable, qScale)
qBlock = double(qBlock);
qTable = double(qTable);
qScale = double(qScale);

qStepDC=8;
DC = qBlock(1,1);

dctBlock = round(((qScale/8)*qTable).*qBlock);
%Gia ton DC oro
dctBlock(1,1) = round(DC*qStepDC);
end

