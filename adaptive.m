% Lukee filmidatakuvista käyriä. Ohjelma valitsee ensimmäisen sarakkeen
% tummuusmaksimien perusteella kuusi paikkaa ja jatkaa käyrien etsimistä
% niiden läheisyydestä

% Mika Väänänen, 2016

format compact
overDirectory = '/media/storage/Asiakirjat/Työt/resolve/';
%overDirectory = '~/Documents/dataa/filmi/MUO/'; % This overdirectory can
%be used for testing. Do note, pictures from IMG_9246.jpg onwards are
%corrupted. Working copies can be found on a external hard drive and the
%original memory cards.

frameWidth = 1011; % Width of a frame; that is, two vertical black lines. 
%Equals 6h separation in data with a 10s resolution. Not used ATM.
directories = ['042/']; %List of reels to be read
%directory = readDirectory();
%kansio = [kansio 'testi/'];
%reelNumber = input('Enter film reel number in a three-digit format (eg. 001): \n','s');
reelReconstruction = [];
wholeReconstruction = cell(1, length(directories(:,1)));

for reelNumber = 1:length(directories(:,1))
    reelReconstruction = [];
    wholeImage = [];
    directory = [overDirectory directories(reelNumber,:)]
    images = dir([directory '*.JPG']);
    beginningImage = 1;
    endImage = length(images);
    for imageNumber = beginningImage:endImage
        try
        %filename = [directory reelNumber '-' num2str(imageNumber) '.jpg'];
        filename = [directory images(imageNumber).name];
        [processing, imageReconstruction, processingHeight] = reconstructImage(filename);
        reelReconstruction = [reelReconstruction imageReconstruction];
        save('/media/storage/Asiakirjat/Työt/resolve/reconstruction.mat')
        catch ME
            disp(ME.identifier)
            disp(' ')
            if(strcmp(ME.identifier, 'MATLAB:UndefinedFunction'))
                break
            end
        end
    end
    wholeReconstruction{reelNumber} = reelReconstruction;
    
end

%%
[processing, imageReconstruction, processingHeight] = reconstructImage(filename);
flippedReconstruction = abs(processingHeight - imageReconstruction);

figure(4)
clf
imshow(processing)
hold on
for imageNumber = 1:length(imageReconstruction(:,1))
    plot(imageReconstruction(imageNumber,:),'.')
end

figure(3)
clf
hold on
for l = 1:length(flippedReconstruction(:,1))
    plot(flippedReconstruction(l,:),'.')
end
