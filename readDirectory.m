% Reads directory input given by user. If no input is given, function
% returns directory named 'testi'.

function directory = readDirectory()
    directory = input('Enter working directory:\n','s');
    if(isempty(directory))
        directory = 'testi/';
    elseif(directory(end) ~= '/')
        directory = [directory '/'];
    end
end