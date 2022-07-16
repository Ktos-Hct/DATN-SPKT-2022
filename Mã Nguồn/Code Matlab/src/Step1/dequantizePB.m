function [dctBlock] = dequantizePB(qBlock, qTable, qScale)
qBlock = double(qBlock);
qTable = double(qTable);
qScale = double(qScale);

dctBlock = round(((qScale/8)*qTable).*qBlock);

end

