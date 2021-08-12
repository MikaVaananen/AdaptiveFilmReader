function column = chooseColumn(processedImage, columnNumber)
        column = processedImage(:,columnNumber);
        column = im2double(255-column); % Creates a negative of the column and converts the values to double
        %sarake = tsmovavg(sarake,'s',9,1); % Smoothes the column; not
        %needed right now
        column = [0; column; 0]; % Adds zeroes as a filling; helps the findpeaks-function to find maxima at the ends of the column
end