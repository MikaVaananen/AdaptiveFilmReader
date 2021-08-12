% Recognizes text in images and removes it.
%Code mostly copied from http://se.mathworks.com/help/vision/ref/detectmserfeatures.html
% Requires functions: BBlimits.m, boundingBoxes.m, combineBoundingBoxes.m,
% mserAlueet.m, mserSuodatus.m, lataaKuva.m
%
% See .m-files of the listed functions for more info.

% Mika Väänänen, 2016
function [processing,textBBoxes] = removeText(filename)
format compact

modifying = readImage(filename);
modifying = modifying(:,:,1); % Selects a single color channel since the images are BW.
[mserRegs,~,mserStats] = mserRegions(modifying);
%try
    [~, mserStats] = mserFilter(mserRegs, mserStats);
    expandedBBoxes = boundingBoxes(modifying,mserStats);
    textBBoxes = combineBoundingBoxes(expandedBBoxes,modifying,mserStats);
    textBBoxes = floor(textBBoxes); % Why is this here?
    
    % Replaces the contents of certain sized text boxes with a proper grey
    % color (measured from the background of the image)
    for i = 1:length(textBBoxes(:,1))
        if(textBBoxes(i,3)*textBBoxes(i,4) > 14e3 && textBBoxes(i,3)*textBBoxes(i,4) < 60e3 || textBBoxes(i,2) > 350 && textBBoxes(i,2)+textBBoxes(i,4) < 650)
            avgValue = modifying(max(textBBoxes(i,2)-5,1),max(textBBoxes(i,1)-5,1));
            modifying(textBBoxes(i,2):textBBoxes(i,2)+textBBoxes(i,4),textBBoxes(i,1):textBBoxes(i,1)+textBBoxes(i,3)) = avgValue;
            %tekstilaatikot = [tekstilaatikot; textBBoxes(i,:)];
        end
    end
    
% catch ME
%     disp(ME.identifier)
%     if(strcmp(ME.identifier, 'MATLAB:badsubscript'))
%         disp('Bad subscript; most likely no text boxes found in image. Continuing...')
%     end
%     textBBoxes = 0;
% end

processing = modifying;


end