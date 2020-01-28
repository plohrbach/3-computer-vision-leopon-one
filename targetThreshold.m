unction[statsTargets,binTargets] = targetThreshold(im);

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
end
end
