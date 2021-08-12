function [ processing, imageReconstruction, processingHeight ] = reconstructImage( filename )
%This function generates a reconstruction of the graphs in picture of the
%magnetometer data
% Mika Väänänen, 2016

disp('Processing image:')
disp(filename)
%try
    processing = removeText(filename);
    processing = imgaussfilt(processing,1); % Smoothes the image to remove noise and bring the graphs out a bit more
    processing = imadjust(processing); % Increases contrast for better graph detection
    processingWidth = length(processing(1,:)); % Width of the image to be processd
    processingHeight = length(processing(:,1));% Height -''-
    firstColumn = chooseColumn(processing, 1); % Selecting first column
    imageMean = mean(mean(im2double(255 - processing))); % Calculates the mean of the image to check if contains any dark traces

    prominence = 0.1;
    minimumHeight = 0.1;

    [imageReconstruction, ~, initialLocs] = initialize(firstColumn, prominence, minimumHeight, processingWidth, imageMean);
    dPixels = 1; % Difference between pixels being read; ie. if dPixel==1; don't skip any pixels. Lower dPixel values allow for tighter search limits in locateValue.m
    for j = 1:length(initialLocs)
        disp('Graph')
        disp(j)

        reconstruction = zeros(1, length(processing(1,:)));
        reconstruction(1) = initialLocs(j);
        for i = 1+dPixels:dPixels:length(processing(1,:))
            value = locateValue(i, reconstruction(i-dPixels),processing);
            if(length(value) < 1)
                reconstruction(i) = reconstruction(i-1);
            else
                reconstruction(i) = value;
            end
        end
        imageReconstruction(j,:) = reconstruction;
    end
    
%  catch ME
%      if(strcmp(ME.identifier, 'MATLAB:imagesci:imread:fileFormat'))
%          disp('Couldn''t identify file format; possibly corrupted file')
%      else
%          disp('An error occurred when processing image in reconstructImage')
%          disp(filename)
%          disp('Continuing anyway...')
%      end
%      rethrow(ME)
% end


end

