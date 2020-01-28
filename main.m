clear all
clc
[cam,prv] = initWebcam;
drawnow
im = get(prv,'CData');
%im_Red = im(:,:,1);
%im_Green = im(:,:,2);
%im_Blue = im(:,:,3);

% im = snapshot(cam);
% imwrite(im,'Image1','BMP');
% colorThresholder(im);

figEXAMPLE = figure('Parent',0);
set(figEXAMPLE,'Name','EW309 - Camera Overlay Test');
axsEXAMPLE = axes('Parent',figEXAMPLE);
bin = createMask3(im);
imgEXAMPLE = imshow(bin,'Parent',axsEXAMPLE);
set(axsEXAMPLE,'NextPlot','add');
x = 320;
y = 240;
h= plot(axsEXAMPLE,x,y,'go','MarkerSize',5);

while(1)
im = get(prv,'CData');
bin = createMask3(im);

binFill = imfill(bin,'holes');
minArea = 2;
binMinArea = bwareaopen(bin,minArea);
[lbl,n] = bwlabel(bin);
stats = regionprops(lbl,'All');
if (length(stats) == 0);
    disp('NO target');
else  
area = stats(1).Area
centroid = stats(2).Centroid
eccentricity = stats(3).Eccentricity
maxArea = 20000;
minArea= 600;
minEcc = 0;
maxEcc = 1;
idx = find(...
     [stats.Area] >= minArea & ...
     [stats.Eccentricity] <= maxEcc);
 
statsTargets = stats(idx);
for i= 1:numel(idx) 
    binTargets{i} = lbl == idx(i);
end
set(imgEXAMPLE,'CData',binTargets{1});
end
drawnow
End
