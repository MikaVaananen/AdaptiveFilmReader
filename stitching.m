%Name: Paresh Kamble
%E-mail: kamble.paresh@gmail.com

function [stitchedImage] = stitching(image1, image2)

columnsToBeCorrelated = 20;


F = im2double(image1(:,:,1));
S = im2double(image2(:,:,1));

[rows cols] = size(F);

Tmp = [];
temp = 0;
S1 = [];
k = 0; 



for j = 1:columnsToBeCorrelated
    for i = 1:rows
        S1(i,j) = S(i,j);
    end
end

for k = 0:cols-columnsToBeCorrelated% to prevent j to go beyond boundaries.
    for j = 1:columnsToBeCorrelated
        F1(:,j) = F(:,k+j);
    end
    temp = corr2(F1,S1);
    Tmp = [Tmp temp]; % Tmp keeps growing, forming a matrix of 1*cols
    temp = 0;
end
% 

[Min_value, Index] = max(Tmp);% .

n_cols = Index + cols - 1;% New column of output image.

Opimg = [];
for i = 1:rows
    for j = 1:Index-1
        Opimg(i,j) = F(i,j);% First image is pasted till Index.
    end
    for k = Index:n_cols
        try
            Opimg(i,k) = S(i,k-Index+1);%Second image is pasted after Index.
        catch ME
            if(strcmp(ME.identifier, 'MATLAB:badsubscript'))
                %disp('Bad subscript found')
                break
            end
        end
    end    
end

[r_Opimg c_Opimg] = size(Opimg);

stitchedImage = Opimg;


% End of Code

end