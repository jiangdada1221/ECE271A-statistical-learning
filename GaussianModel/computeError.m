img_mask = imread('cheetah_mask.bmp');
img_mask = img_mask / 255;

error_8 = 0;
error_64 = 0;

for i = 1:rows
    for j = 1:cols
        if img_mask(i,j) ~= block8(i,j)
            error_8 = error_8 + 1;
        end
        if img_mask(i,j) ~= block64(i,j)
            error_64 = error_64 + 1;
        end
    end
end

error_8 = error_8 / (rows*cols);
error_64 = error_64/(rows*cols);