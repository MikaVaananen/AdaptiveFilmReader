% Function alusta(ekaSarake, prominenssi, minimikorkeus,kasiteltavaLeveys)
% initializes each image to be digitized.
%
%
% Arguments:
%-------------------------------------------------------------
% firstColumn - contains the first column of pixels of the image
%
% prominence - minimum prominence of the peaks to be searched
%
% minimumHeight - minimum height of the peaks
%
% processingWidth - width of the image being processed (length in x direction)
%
%
% Return values:
%-------------------------------------------------------------
% reconstruction - initial reconstruction of the plots; ie. 6 x
% processingWidth sized matrix, first column contains the peaks of the
% first column and the other elements are zeroes.
%
%prominence - if not enough peaks are found in the first column, the
%prominence is lowered and is returned.
%
%locs - the locations of the peaks are returned.


function [reconstruction,prominence,locs] = initialize(firstColumn, prominence, minimumHeight, processingWidth, imageMean)
disp('Initializing image...')
if(imageMean <= 0.18)
    locs = [35; 100; 300; 420; 780; 900];
else
    [pks,locs,~,proms] = findpeaks(firstColumn,'MinPeakProminence',prominence,'MinPeakHeight',minimumHeight);
    while(length(locs) < 6)
        prominence = 0.9*prominence;
        [~,locs] = findpeaks(firstColumn,'MinPeakProminence',prominence);
    end
    
    while(length(locs) > 6)
        [~,smallestMaximum] = min(proms);
        locs(smallestMaximum) = [];
        proms(smallestMaximum) = [];
    end
    
end

%     prominenssi_temp = prominenssi;
%     while(length(locs) ~= 6)
%         disp('Aloitusarvoja')
%         disp(length(locs))
%         if(length(locs) > 6)
%             prominenssi_temp = 1.05*prominenssi_temp;
%             [~,locs] = findpeaks(ekaSarake,'MinPeakProminence',prominenssi_temp);
%         elseif(length(locs) < 6)
%             prominenssi_temp = 0.95*prominenssi_temp;
%             [~,locs] = findpeaks(ekaSarake,'MinPeakProminence',prominenssi_temp);
%         end
%     end

locs = fliplr(locs)';

reconstruction = zeros(6,processingWidth);
reconstruction(:,1) = locs;
end