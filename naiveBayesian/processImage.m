pri_cheetah = 250 / (1053+250);
pri_grass = 1053/(1053+250);
% pri_cheetah = 0.3;
% pri_grass = 0.7;

img = imread('cheetah.bmp');
[rows,cols] = size(img);
block8 = zeros(rows-7,cols-7);
%input have to be abs first 
for row=1:rows-7
    for col = 1:cols-7
        DCT = abs(dct2(img(row:row+7,col:col+7)));
        zigzag_matrix = zigzag(abs(DCT));
        index = zigSecond_large(zigzag_matrix);
        block8(row,col) = index;
    end
end

result = zeros(rows,cols);
for row=1:rows-7
    for col = 1:cols-7
        probCheetah = cacheY_FG(block8(row,col)) * pri_cheetah;
        probBackground = cacheY(block8(row,col)) * pri_grass;
        if probCheetah > probBackground + 0.0011
            result(row,col) = 1;
        else 
            result(row,col) = 0;
        end
    end
end
imshow(result)
% for i = rows-7+1:rows
%     result(1,i)=0;
% end
% 
% for i = cols-7+1:cols
%     result(i,1) = 0;
% end


% imshow(result)














