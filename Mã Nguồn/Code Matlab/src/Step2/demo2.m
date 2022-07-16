
bName = 'coastguard';
fExtension = 'tiff';
startFrame = 0;%Fame bắt đầu
GoP = 'IBBP';%Ghep 4 frame thanh 1 lien ket(Nhóm hình ảnh).
numOfGoPs = 1;%So luong lien ket 4 frame 1 lan 
qScale = 8;%Khoảng lượng tử

fprintf('Tao lien ket cho %d khung\n',length(GoP)*numOfGoPs);
encodeMPEG(bName, fExtension, startFrame, GoP, numOfGoPs, qScale);
fprintf('Kết thúc mã hóa hình ảnh\n')
load('Stream.mat')
Bytes = getSeqEntityBits(SeqEntity)/8;
%720*576*3*4 = 4976640 bytes
fprintf('Kích thước tệp nén %d bytes\n',Bytes);
cd decode %Mở bộ giải mã
decodeMPEG('Stream.mat','decodePicture');

cd saveImages %Lưu ảnh đã được giải mã
for i=startFrame:startFrame+length(GoP)*numOfGoPs-1
RGB1 = imread(strcat('decodePicture',num2str(i),'.tiff'));
cd ../../../images/    
RGB2 = imread(strcat('coastguard',num2str(i),'.tiff'));
cd ../Step2/decode/saveImages/

Mean_absolute_error = sum(sum(sum(abs(RGB1-RGB2))))/(size(RGB1,1)*size(RGB1,2)*3);
fprintf('Sai so tuyệt đối của mỗi fame ảnh %d = %f\n',i,Mean_absolute_error);
end

coastguard2tiff=imread('decodePicture2.tiff');
cd ../../../Step1
Y = ccir2ycrcb(coastguard2tiff);%Chuyển đồi RPG->YUV
image(Y);
title('Hình ảnh sau chuyển đổi coastguard002.tiff')
cd ../Step2/decode/saveImages
