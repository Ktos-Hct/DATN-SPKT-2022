
addpath(genpath('../images'));%thêm thư viên hinh ảnh.
%biểu diễn các hàm ccir2ycrcb() và ycrcb2ccir()
figure(1)
subplot(1,2,1)
RGB = imread('coastguard3.tiff');
image(RGB);
title('Hiển thị anh gốc');

[Y, Cr, Cb]=ccir2ycrcb(imread('coastguard3.tiff'));%Chuyển RPG->YUV
prIm = ycrcb2ccir(Y,Cr,Cb);%YUV->RPG
subplot(1,2,2)
image(prIm);
title('Hình ảnh sau khi chuyển đổi');

%%
%Trình bày về chức năng mostEstP
macroblock0=1; %H Đánh các số bắt đầu từ 1
[Y, Cr, Cb]=ccir2ycrcb(imread('coastguard3.tiff'));%chuyển ảnh coastguard3.tiff sang anh YUV
[refFrameY, refFrameCr, refFrameCb]=ccir2ycrcb(imread('coastguard1.tiff'));%Chuyển ảnh coastguard1.tiff sang YUV
[eMBY, eMBCr, eMBCb, mV] = motEstP(Y, Cr, Cb, macroblock0,refFrameY, refFrameCr, refFrameCb);

display('MotionVector');%Hiển thị vectorchuyeenr động
mV

figure(2)
subplot(2,2,1)
image(Y(1:16,1:16));
title('MacroBlock0-coastguard3');

subplot(2,2,2)
image(refFrameY(mV(1,1)+1:mV(1,1)+16,mV(2,1)+1:mV(2,1)+16));
title('MacroBlock0-coastguard1');

subplot(2,2,3)
image(eMBY)
title('Sfalma-eMBY');

subplot(2,2,4)
image(refFrameY(1:7+16,1:7+16));
title('Sunolikh perioxh anazhthseis');

rmpath(genpath('../images'));