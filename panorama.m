% Stitches together film data images
% Uses a stitching function by Paresh Kamble, see attached license file for
% details
% Mika Väänänen, 2016

function image = panorama(startImage, endImage)

    image1 = imread(sprintf('~/Documents/dataa/filmiltä/MUO/035/crop/035-%d.jpg',startImage));
    image2 = imread(sprintf('~/Documents/dataa/filmiltä/MUO/035/crop/035-%d.jpg',startImage+1));
    image1 = image1(100:1000,1:end-117,:); % Crops out the holes in the film; they cause too man correlation points and mess everything up
    % 117 pixels was measured to be the width of a black bar on the right side of the pictures
    image2 = image2(100:1000,:,:); % Ditto

    stitched = stitching(image1,image2); % Creation of the stitch of the first two images as a starting point for the loop

    for i = startImage+2:endImage
        image2 = imread(sprintf('~/Documents/dataa/filmiltä/MUO/035/crop/035-%d.jpg',i));
        image2 = image2(100:1000,:,:);
    
        image2width = length(image2(1,1:end-117,1));
    
        stitchedBeginning = stitched(:,1:end-image2width,:); % Splits the stitched image in two parts
        stitchedEnd = stitched(:,end-image2width+1:end,:); % and uses the latter part as a new image1 for the stitching
        image1 = stitchedEnd;
    
        newStitched = stitching(image1,image2(:,1:end-117,1));
    
        stitched = [stitchedBeginning newStitched];
    end
end