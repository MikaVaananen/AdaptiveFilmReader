% lataaKuva(tiedosto) function reads a image. The filename of the image is
% given to the function as an argument. The function also crops the image
% to desired size.

function processing = readImage(filename)
    image = imread(filename); % Reads the image to variable image
    beginningWidth = 900; % Beginning x-value of the area to be cropped
    endWidth = 2048; % The value to be substracted must be measured independently % The value to be substracted must be measured independently
    
    % These values crop out the holes in the film
    beginningHeight = 689; % Beginning height, counted from top left
    endHeight = 1262; % End height, counted from top left
    processing = image(beginningHeight:endHeight,beginningWidth:endWidth,1);
    %kasiteltava = [kasiteltava; zeros(size(kasiteltava(1,:)))];
end