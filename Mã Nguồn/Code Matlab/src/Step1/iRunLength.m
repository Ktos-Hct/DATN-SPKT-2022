function [qBlock] = iRunLength(runSymbols)
y = 1;
x = 1;
x_max = 8;
y_max = 8;
x_min = 1;
y_min = 1;
i = 1;
qBlock = zeros(x_max, y_max);
lineZigZag = zeros(1,x_max*y_max);

%Diastash toy runSymbols -> Rx2
R=size(runSymbols,1);
stepL = 1;
%8a ftia3oume enan gramiko pinaka zigzag pou sthn sunexeia
%8a ton metatre3oume ston epi8umhto 8X8 qBlock zigzag
lineZigZag(1)=runSymbols(1,2);
for j=2:R
stepL = stepL+runSymbols(j,1)+1;    
lineZigZag(stepL)=runSymbols(j,2);
end

%lineZigZag --> qBlock 8x8
while ((x <= x_max) && (y <= y_max))
%Metakinhsh pros ta panw
if (mod(y + x, 2) == 0)               

if (x == x_min)
    qBlock(x, y) = lineZigZag(i);
    if (y == y_max)
    x = x + 1;
    else
      y = y + 1;
    end
i = i + 1;

elseif ((y == y_max) && (x < x_max))
    qBlock(x, y) = lineZigZag(i);
    x = x + 1;
    i = i + 1;

elseif ((x > x_min) && (y < y_max))
    qBlock(x, y) = lineZigZag(i);
    x = x - 1;
    y = y + 1;
    i = i + 1;
end
%Pros ta katw
else                                  
if ((x == x_max) && (y <= y_max))
    qBlock(x, y) = lineZigZag(i);
    y = y + 1;
    i = i + 1;

elseif (y == y_min)
    qBlock(x, y) = lineZigZag(i);

  if (x == x_max)
  y = y + 1;
  else
  x = x + 1;
  end

i = i + 1;
elseif ((x < x_max) && (y > y_min))
    qBlock(x, y) = lineZigZag(i);
    x = x + 1;
    y = y - 1;
    i = i + 1;
end

end
%Gia to teleutaio sthxeio
if ((x == x_max) && (y == y_max))
qBlock(x, y) = lineZigZag(i);
break
end

end

end
