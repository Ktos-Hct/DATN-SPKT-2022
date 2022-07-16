function [qBlock] = quantizePB(dctBlock, qTable, qScale)
dctBlock = double(dctBlock);
qTable = double(qTable);
qScale = double(qScale);

qBlock = round(8*dctBlock./(qScale*qTable));

end

