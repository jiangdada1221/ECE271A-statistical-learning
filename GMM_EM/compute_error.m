function error = compute_error(block64)

img_mask = imread('cheetah_mask.bmp');
img_mask = img_mask / 255;
compare = (block64 ~= img_mask);
error_64 = sum(sum(compare));
[rows,cols] = size(img_mask);
error = error_64 / (rows*cols);

end