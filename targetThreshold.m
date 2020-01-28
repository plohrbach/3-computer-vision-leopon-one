function[statsTargets,binTargets] = targetThreshold(im);

  % First, gentlemen, please add some comments!

  % 1. Pick out orange using function from color threshold tool
  bin = createMask3(im); 

  % 2. Do some image processing to fill holes and reject tiny specks of noise
  binFill = imfill(bin,'holes');
  minArea = 2;
  binMinArea = bwareaopen(bin,minArea);

  % 3. Using the image, label contiguous regions (blobs)
  [lbl,n] = bwlabel(bin);

  % 4. For the labeled contiguous regions, get their stats
  stats = regionprops(lbl,'All');
  if (length(stats) == 0);
    disp('NO target');

    % if there is no target you should initialize statsTargets and
    % binTargets to be empty or something?
    statsTargets = []; % empty array 
    binTargets = {}; % empty cell array
  else
    % These lines are suspect; you don't kno that element (1), (2), or (3)
    % is a good target? 
    %area = stats(1).Area 
    %centroid = stats(2).Centroid
    %eccentricity = stats(3).Eccentricity
    
    maxArea = 20000; % largest blob you accept, about 140x140 pixels
    minArea= 600; % smallest blob you accept, about 24x24 pixels 
    minEcc = 0; % 0 is perfect circle
    maxEcc = 1; % tweak this
    idx = find(...
		[stats.Area] >= minArea & ...
		[stats.Eccentricity] <= maxEcc);

    % Assign function output variables
    % statsTargets is a structured array of the blobs bigger than minArea and
    % more round than maxEcc
    statsTargets = stats(idx);

    % binTargets is a cell array of binary images of the acceptable blobs
    for i= 1:numel(idx) 
      binTargets{i} = lbl == idx(i);
    end
  end
end
