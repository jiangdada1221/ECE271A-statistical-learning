load('TrainingSamplesDCT_8_new.mat');
BG = TrainsampleDCT_BG;
FG = TrainsampleDCT_FG;
img = imread('cheetah.bmp');
img = im2double(img);
[rows,cols] = size(img);
img_mask = imread('cheetah_mask.bmp');
img_mask = img_mask / 255;
prior_BG = size(BG,1)/(size(BG,1)+size(FG,1));
prior_FG = size(FG,1)/(size(BG,1)+size(FG,1));

zigzags = zeros(rows,cols,64);
for row = 1:rows-7
    for col = 1:cols-7
        DCT = (dct2(img(row:row+7,col:col+7)));
        zigzag_matrix = zigzag(DCT);
        zigzag_matrix = zigzag_matrix';
        zigzags(row,col,:) = zigzag_matrix;
    end
end