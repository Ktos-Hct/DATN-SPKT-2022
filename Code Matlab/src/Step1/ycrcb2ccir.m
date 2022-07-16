function [ frameRGB ] = ycrcb2ccir( frameY, frameCr, frameCb )
%Lặp lại các cạnh để khôi phục các kích thước tương ứng
a=[];
b=[];
for i=1:8
    a=[a frameY(:,1)];
    b=[b frameY(:,end)];
end
frameY = [a(:,1:5) frameY b(:,1:3)];
a=[];
b=[];
for i=1:2
    a=[a frameCr(:,1)];
    b=[b frameCr(:,end)];
end
frameCr = [a frameCr b];
a=[];
b=[];
for i=1:2
    a=[a frameCb(:,1)];
    b=[b frameCb(:,end)];
end
frameCb = [a frameCb b];

frameY=double(frameY);
frameCr=double(frameCr); 
frameCb=double(frameCb);

%%
%Bộ lọc để lấy mẫu ngược
%Bộ lọc thông thấp
Low_Y_filter=[-12 0 140 256 140 0 -12]';
Low_CbCr_filter=[1 3 3 1]';
length_CbCr=length(Low_CbCr_filter);
length_Y=length(Low_Y_filter);

%Chỉ lấy mẫu theo chiều dọc cho Cr Cb
Cr=zeros(size(frameCr).*[2 1]);
Cb=zeros(size(frameCb).*[2 1]);

Cr(2:2:end,:)=frameCr(:,:); 
Cb(2:2:end,:)=frameCb(:,:); 

frameCr=Cr;
frameCb=Cb;

%Áp dụng bộ lọc
for i=1:length(frameCb(:,1))-length_CbCr+1
   frameCr(i,:)=(Low_CbCr_filter'*frameCr(i:(i+length_CbCr-1),:))/4;
   frameCb(i,:)=(Low_CbCr_filter'*frameCb(i:(i+length_CbCr-1),:))/4;
end

frameCr(end-length_CbCr-1:2:end,:) = frameCr(end-length_CbCr:2:end,:);
frameCb(end-length_CbCr-1:2:end,:) = frameCb(end-length_CbCr:2:end,:);
%%
%Bộ lọc ngang và lấy mẫu ngược
%Trước khi áp dụng bộ lọc, chúng ta phải chèn các số không vào giữa chúng
%mẫu để chúng tôi tăng gấp đôi kích thước chiều ngang
Y=zeros(size(frameY).*[1 2]);
Cr=zeros(size(frameCr).*[1 2]);
Cb=zeros(size(frameCb).*[1 2]);

%và chúng tôi nhập dữ liệu bằng không trung gian
Y(:,2:2:end)=frameY(:,:);
Cr(:,2:2:end)=frameCr(:,:);
Cb(:,2:2:end)=frameCb(:,:);


frameY=Y;
frameCr=Cr;
frameCb=Cb;
%ứng dụng lọc
for i=1:length(frameY(1,:))-length_Y+1
   frameY(:,i)=(frameY(:,i:(i+length_Y-1))*Low_Y_filter)/256;
end
frameY(:,end-length_Y:2:end) = (frameY(:,end-length_Y-1:2:end-1)+frameY(:,end-length_Y-3:2:end-3))/2;

for i=1:length(frameCb(1,:))-length_CbCr+1
   frameCr(:,i)=(frameCr(:,i:(i+length_CbCr-1))*Low_CbCr_filter)/4;
   frameCb(:,i)=(frameCb(:,i:(i+length_CbCr-1))*Low_CbCr_filter)/4;
end
frameCr(:,end-length_CbCr-1:2:end) = (frameCr(:,end-length_CbCr:2:end)+frameCr(:,end-length_CbCr-2:2:end-2))/2;
frameCb(:,end-length_CbCr-1:2:end) = (frameCb(:,end-length_CbCr:2:end)+frameCb(:,end-length_CbCr-2:2:end-2))/2;
%%
%Lấy mẫu theo chiều dọc
Y=zeros(size(frameY).*[2 1]);
Cr=zeros(size(frameCr).*[2 1]);
Cb=zeros(size(frameCb).*[2 1]);


Y(1:2:end,:)=frameY(:,:); 
Cr(1:2:end,:)=frameCr(:,:); 
Cb(1:2:end,:)=frameCb(:,:); 

Y(2:2:end-1,:)=(frameY(1:end-1,:)+frameY(2:end,:))/2; 
Cr(2:2:end-1,:)=(frameCr(1:end-1,:)+frameCr(2:end,:))/2;  
Cb(2:2:end-1,:)=(frameCb(1:end-1,:)+frameCb(2:end,:))/2;

Y(end,:) = Y(end-1,:);
Cr(end,:) = Cr(end-1,:);
Cb(end,:) = Cb(end-1,:);

frameCr=Cr;
frameCb=Cb;
%%
%Lấy mẫu theo chiều ngang chỉ dành cho Cb Cr
Cr=zeros(size(frameCr).*[1 2]);
Cb=zeros(size(frameCb).*[1 2]);

Cr(:,1:2:end)=frameCr(:,:); 
Cb(:,1:2:end)=frameCb(:,:); 

Cr(:,2:2:end-1)=(frameCr(:,1:end-1)+frameCr(:,2:end))/2;  
Cb(:,2:2:end-1)=(frameCb(:,1:end-1)+frameCb(:,2:end))/2;  
Cr(:,end) = Cr(:,end-1);
Cb(:,end) = Cb(:,end-1);

%Chuyển đổi YCrCb-> RGB
%%
T = [0.299   0.587   0.114
     0.5000 -0.4187 -0.0813
    -0.1687 -0.3313  0.5000];
T=inv(T);

frameRGB=zeros(size(Y));
frameRGB(:,:,1) =  T(1,1)*Y + T(1,2)*(Cr-128) + T(1,3)*(Cb-128);
frameRGB(:,:,2) = T(2,1)*Y + T(2,2)*(Cr-128) + T(2,3)*(Cb-128);
frameRGB(:,:,3) = T(3,1)*Y + T(3,2)*(Cr-128) + T(3,3)*(Cb-128);

frameRGB = uint8(frameRGB);

end

