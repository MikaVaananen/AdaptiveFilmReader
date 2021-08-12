% Creates rectangular bounding boxes for MSER regions in an image.

function [xmin, ymin, xmax, ymax] = BBlimits(processing, mserStats)

% Get bounding boxes for all the regions
bboxes = vertcat(mserStats.BoundingBox);
if(isempty(bboxes))
    bboxes = [1 1 1 1]
end

% Convert from the [x y width height] bounding box format to the [xmin ymin
% xmax ymax] format for convenience.
xmin = bboxes(:,1);
ymin = bboxes(:,2);
xmax = xmin + bboxes(:,3) - 1;
ymax = ymin + bboxes(:,4) - 1;

% Expand the bounding boxes by a small amount.
expansionAmount = 0.02;
xmin = (1-expansionAmount) * xmin;
ymin = (1-expansionAmount) * ymin;
xmax = (1+expansionAmount) * xmax;
ymax = (1+expansionAmount) * ymax;

% Clip the bounding boxes to be within the image bounds
xmin = max(xmin, 1);
ymin = max(ymin, 1);
xmax = min(xmax, size(processing,2));
ymax = min(ymax, size(processing,1));

end