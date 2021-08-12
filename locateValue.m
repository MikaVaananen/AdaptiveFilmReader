% Searches for a single maximum within a piece of a column of a given
% image.

% Mika Väänänen, 2016

function [ value ] = locateValue(i,previousValue,processing)

column = chooseColumn(processing, i);
offset = 10; % Determines the search limits; 
%lower dPixel values allow for tighter limits

upperlimit = previousValue - offset; % Sets the upper boundary for the search area, in other words previous value minus 20px
if (upperlimit < 1) % Makes sure upper limit is within image bounds
    upperlimit = 1;
end
upperlimit = floor(upperlimit); % Converts the upper limit to an integer

lowerlimit = previousValue + offset; % Sets the lower boundary for the search area
if(lowerlimit > length(column) ) % Makes sure lower limit is within image bounds
    lowerlimit = length(column);
end
lowerlimit = floor(lowerlimit); % Converts the lower limit to an integer

columnAvg = mean(column);
columnPartAvg = mean(column(upperlimit:lowerlimit));
if(columnAvg > 0.4 || columnPartAvg < nanmean(column)) % Checks if the column is too dark (avg. too high) or too light (avg. too low);
    %ie. if the value is within a frame border (black vertical line) or
    %a calibration area
    value = previousValue;
else
    % Note: origin for the limit coordinate system is in the upper left
    % corner of the image. Thus, the "upper limit" has a lower value than
    % the "lower limit". Upper and lower refer to their places in the
    % image, not their values as such.
    
    [~, value] = max(column(upperlimit:lowerlimit));
    
    % Below is the old, more "refined" method of finding the maximum value
    % instead of using the max(area)-function. Why do things simply when
    % you can write 30 lines of code...
    
    %     [pks,value] = findpeaks(column(upperlimit:lowerlimit),'MinPeakProminence',prominence); % Etsii potentiaaliset arvot ja niiden voimakkuudet
    %
    %     prominence_temp = prominence;
    %     iteration = 0;
    %     while(length(value) ~= 1) % If there's more than a single value
    %         iteration = iteration + 1;
    %         if(iteration == 100)
    %             value = previousValue;
    %         end
    %         if(length(value) < 1)
    %             upperlimit = upperlimit - 10;
    %             lowerlimit = lowerlimit + 10;
    %             if(upperlimit <= 1)
    %                 upperlimit = 1;
    %             end
    %             if(lowerlimit >= length(column))
    %                 lowerlimit = length(column);
    %             end
    %             [pks,value] = findpeaks(column(upperlimit:lowerlimit),'MinPeakProminence',prominence_temp);
    %
    %         elseif(length(value) == 2)
    %             value = value(1);
    %         elseif(length(value) > 2)
    %             prominence_temp = 1.1*prominence_temp;
    %             [pks,value] = findpeaks(column(upperlimit:lowerlimit),'MinPeakProminence',prominence_temp);
    %         end
    %     end
    
    value = upperlimit + value; % Transforms the value from within the search bounds in to the film reel coordinates
    if (value > length(column))
        value = length(column);
    end
    
    if(abs(previousValue - value) > 25)
        value = previousValue;
    end
end

end