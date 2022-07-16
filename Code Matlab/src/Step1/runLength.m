function [runSymbols] = runLength(qBlock)
%Arxikopoioume
x_max = size(qBlock, 1);
y_max = size(qBlock, 2);
y_min = 1;
x_min = 1;
y = 1;
x = 1;
i = 1;
%8a ftiajoume ena pinaka grammiko me thn 
%antistoixh diata3h se zigzag
lineZigZag = zeros(1, x_max * y_max);

while (1)  
if (mod(y + x, 2) == 0)% going up
%An ftasoume sthn prwth grammh
if (x == y_min)       
  lineZigZag(i) = qBlock(x, y);
   if (y == y_max)
    x = x + 1;
    else
    y = y + 1;
   end
    i = i + 1;
%Gia thn teleutaia steilh
elseif ((y == y_max) && (x < x_max))
    lineZigZag(i) = qBlock(x, y);
    x = x + 1;
    i = i + 1;
%Endiamesa
elseif ((x > y_min) && (y < y_max))
    lineZigZag(i) = qBlock(x, y);
    x = x - 1;
    y = y + 1;
    i = i + 1;
end

else % going down
%An ftasoume sthn prwth grammh
if ((x == x_max) && (y <= y_max)) 
    lineZigZag(i) = qBlock(x, y);
    y = y + 1;
    i = i + 1;
%Gia thn teleutaia steilh
elseif (y == x_min)  
    lineZigZag(i) = qBlock(x, y);

    if (x == x_max)
  y = y + 1;
else
      x = x + 1;
    end;

    i = i + 1;
%Endiamesa
elseif ((x < x_max) && (y > x_min))     
    lineZigZag(i) = qBlock(x, y);
    x = x + 1;
    y = y - 1;
    i = i + 1;
end
end

%Otan ftasoume sto teleutaio stoixeio 64
if ((x == x_max) && (y == y_max))          
lineZigZag(i) = qBlock(x, y);
break
end
end

runSymbols = [0 lineZigZag(1)];
zerosNum = 0;
for i=2:64
 if lineZigZag(i)~=0
    runSymbols = [runSymbols ;zerosNum  lineZigZag(i)];
    zerosNum=-1;
 end
 zerosNum=zerosNum+1;
end


end
