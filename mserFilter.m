% Filters out unwanted MSER regions.

function [mserRegions,mserStats] = mserFilter(mserRegions, mserStats)

bbox = vertcat(mserStats.BoundingBox);
w = bbox(:,3);
h = bbox(:,4);
aspectRatio = w./h;

filterIdx = aspectRatio' > 2;
filterIdx = filterIdx | [mserStats.Eccentricity] > .995;
filterIdx = filterIdx | [mserStats.Solidity] < .25;
filterIdx = filterIdx | [mserStats.Extent] < 0.2 | [mserStats.Extent] > 0.9;
filterIdx = filterIdx | [mserStats.EulerNumber] < -4;

mserStats(filterIdx) = [];
mserRegions(filterIdx) = [];

end