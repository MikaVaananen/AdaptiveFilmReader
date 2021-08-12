% Expand the bounding boxes of MSER regions of a given image.

function [expandedBBoxes] = boundingBoxes(processing,mserStats)

[xmin, ymin, xmax, ymax] = BBlimits(processing, mserStats); % Finds the x and y coordinates of the corners of the bounding boxes in the image.
expandedBBoxes = [xmin ymin xmax-xmin+1 ymax-ymin+1];

end