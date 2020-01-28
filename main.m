% Please put some comments here as to what all this is doing
clear all % clear memory
clc % clear command window
[cam,prv] = initWebcam; % initialize Webcam object
drawnow % call to allow Webcam to update 
im = get(prv,'CData'); % grab first image

% These lines you don't need; delete them!
%im_Red = im(:,:,1);
%im_Green = im(:,:,2);
%im_Blue = im(:,:,3);
% im = snapshot(cam);
% imwrite(im,'Image1','BMP');
% colorThresholder(im);





% Initialize camera overlay window
figEXAMPLE = figure('Parent',0); % create figure
set(figEXAMPLE,'Name','EW309 - Camera Overlay Test'); % change its name
axsEXAMPLE = axes('Parent',figEXAMPLE); % add empty axes
bin = createMask3(im);
imgEXAMPLE = imshow(bin,'Parent',axsEXAMPLE); % show an image and get handle
set(axsEXAMPLE,'NextPlot','add'); % set plot window hold on
x = 320; % can you do this using size(im) somehow?
y = 240; % can you do this using size(im) somehow?
h= plot(axsEXAMPLE,x,y,'go','MarkerSize',5); % plot center crosshair as a green dot sight




% update loop
while(1)
  im = get(prv,'CData'); % get new image
  bin = createMask3(im);

  % The lines here should be replaced with a call to your
  % targetThreshold function!
  %binFill = imfill(bin,'holes');
  %minArea = 2;
  %binMinArea = bwareaopen(bin,minArea);
  %[lbl,n] = bwlabel(bin);
  %stats = regionprops(lbl,'All');
  %if (length(stats) == 0);
  %  disp('NO target');
  %else  
  %  area = stats(1).Area
  %  centroid = stats(2).Centroid
  %  eccentricity = stats(3).Eccentricity
  %  maxArea = 20000;
  %  minArea= 600;
  %  minEcc = 0;
  %  maxEcc = 1;
  %  idx = find(...
  %	[stats.Area] >= minArea & ...
  % [stats.Eccentricity] <= maxEcc);
  %  
  %  statsTargets = stats(idx);
  %  for i= 1:numel(idx) 
  %    binTargets{i} = lbl == idx(i);
  %  end
  %  set(imgEXAMPLE,'CData',binTargets{1});
  %end

  % plot image and overlays
  set(imgEXAMPLE,'CData',im); % placeholder for now
  % set centroid plot location if it exists
  drawnow
end
