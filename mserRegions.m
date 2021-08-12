% Detects MSER-regions in a given image. See
% detectMSERFeatures-documentation for more info.

function [mserRegs, mserConn, mserStats] = mserRegions(kasiteltava)

[mserRegs,mserConn] = detectMSERFeatures(kasiteltava,'ThresholdDelta',5);
mserStats = regionprops(mserConn, 'BoundingBox', 'Eccentricity', 'Solidity', 'Extent', 'Euler', 'Image');

end