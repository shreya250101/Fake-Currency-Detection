clear all;
close all;
Ireal = imread("500real.jpg"); % Real
Iscaned = imread("500fake.jpg"); % scaned

%%//BEFORE ANAYLYSING
hsvImageReal = rgb2hsv(Ireal);
hsvImagescaned = rgb2hsv(Iscaned);
figure;
%image1
imshow([hsvImageReal(:,:,1) hsvImageReal(:,:,2) hsvImageReal(:,:,3)]) ;
figure;
%image2
imshow([hsvImagescaned(:,:,1) hsvImagescaned(:,:,2) hsvImagescaned(:,:,3)]);


%%//Initial segmentation
croppedImageReal = hsvImageReal(:,190:200,:);
croppedImagescaned = hsvImagescaned(:,190:200,:);
satThresh = 0.4;
valThresh = 0.3;
BWImageReal = (croppedImageReal(:,:,2) > satThresh & croppedImageReal(:,:,3) < valThresh);
figure;
subplot(1,2,1);
%image3
imshow(BWImageReal);
title('Real Currency');
BWImagescaned = (croppedImagescaned(:,:,2) > satThresh & croppedImagescaned(:,:,3) < valThresh);
subplot(1,2,2);
imshow(BWImagescaned);
title('Fake Currency');

%%//AFTER THE PROCESS
se = strel('line', 6, 90);
BWImageCloseReal = imclose(BWImageReal, se);
BWImageClosescaned = imclose(BWImagescaned, se);

%%//Area open the image
figure;
areaopenReal = bwareaopen(BWImageCloseReal, 15);
subplot(1,2,1);
%image4
imshow(areaopenReal);
title('Real Currency');
subplot(1,2,2);
areaopenscaned = bwareaopen(BWImageClosescaned, 15);
imshow(areaopenscaned);
title('Fake Currency ');



blackStripReal = Ireal(58:110,50:80,:);
blackStripscaned = Iscaned(58:110,50:80,:);

figure;
subplot(1,3,1);
%image5
imshow(blackStripReal);
title('Real Currency');
subplot(1,3,2);
imshow(blackStripscaned);
title('Fake Currency');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);

figure;
subplot(1,3,1);
%image6
imshow(blackStripReal);
title('Real Currency');
subplot(1,3,2);
imshow(blackStripscaned);
title('Fake Currency');
