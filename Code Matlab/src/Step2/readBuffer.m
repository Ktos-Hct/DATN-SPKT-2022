function out = readBuffer(i)
%i = 1 or 2 exclusively
global Buffer
if(i==1)
 out = Buffer.pic1;
else
 out = Buffer.pic2;
end 

end