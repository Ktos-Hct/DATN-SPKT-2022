function pushFlushPic(pic, tempRef, outFName)

frameRGB = ycrcb2ccir(pic.decPic.frameY, pic.decPic.frameCr, pic.decPic.frameCb);
extension = '.tiff';
picName = strcat(outFName,num2str(tempRef),extension);

%If the folder doesn't exist create a folder
%so that the images can be saved 
myFolder = 'saveImages';
if ~exist(myFolder, 'dir'); 
    mkdir(myFolder);
end

currentDirectoy = pwd;
fullFileName = fullfile(currentDirectoy,myFolder, picName);
imwrite(frameRGB, fullFileName);

end