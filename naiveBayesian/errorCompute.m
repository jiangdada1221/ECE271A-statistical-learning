img2 = imread('cheetah_mask.bmp');
img2 = img2 / 255;
diff = 0;

for i = 1:255
    for j = 1:270
        if img2(i,j) ~= result(i,j);
            diff = diff + 1;
        end
    end
end

errorImg = diff / (255 * 270);