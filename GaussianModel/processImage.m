img = imread('cheetah.bmp');
img = im2double(img);
[rows,cols] = size(img);
block8 = zeros(rows,cols);

%add padding
imgU = [img ; zeros(7,cols)];
imgR = [imgU zeros(rows+7,7)];

prior_FG = 255 / (255+ 1053);
prior_BG = 1053 / (255 + 1053);

%pick 1 2 3 4 5 50 57 58 features

data8_FG = [dataFG(:,1:5) dataFG(:,50) dataFG(:,57) dataFG(:,58)];
data8_BG = [dataBG(:,1:5) dataBG(:,50) dataBG(:,57) dataBG(:,58)];
covFG = cov(data8_FG);
covBG = cov(data8_BG);
muFG8 = mean(data8_FG)';
muBG8 = mean(data8_BG)';

alphaFG = (2*pi)^8 * det(covFG);
alphaBG =  (2*pi)^8 * det(covBG);
inv_covFG = pinv(covFG);
inv_covBG = pinv(covBG);


for row=1:rows-7
    for col = 1:cols-7
        DCT = (dct2(img(row:row+7,col:col+7)));
        zigzag_matrix = zigzag(DCT);
        pick8 = pick_8(zigzag_matrix);
        proFG = 0;
        proBG = 0;
        proFG = proFG -0.5 * (pick8 - muFG8)' * inv_covFG * (pick8 - muFG8)-0.5*log(alphaFG) + log(prior_FG);
        proBG = proBG -0.5 * (pick8 - muBG8)' * inv_covBG * (pick8 - muBG8)-0.5*log(alphaBG) + log(prior_BG);
        if proFG  > proBG
            block8(row,col) = 1;
        end
    end
end
CovFG = cov(dataFG);
CovBG = cov(dataBG);
alphaFG2 = (2*pi)^64 * det(CovFG);
alphaBG2 =  (2*pi)^64 * det(CovBG);
inv_Cov_FG = pinv(CovFG);
inv_Cov_BG = pinv(CovBG);
%%%%%print 64 features
block64 = ones(rows,cols);
muFG = mean(dataFG)';
muBG = mean(dataBG)';
for row=1:rows-7
    for col = 1:cols-7
        DCT = (dct2(img(row:row+7,col:col+7)));
        zigzag_matrix = zigzag(DCT);
        zigzag_matrix = zigzag_matrix';
        proFG = 0;
        proBG = 0;
        proFG = proFG -0.5 * (zigzag_matrix - muFG)' * inv_Cov_FG * (zigzag_matrix - muFG)-0.5*log(alphaFG2) + log(prior_FG);
        proBG = proBG -0.5 * (zigzag_matrix - muBG)' * inv_Cov_BG * (zigzag_matrix - muBG)-0.5*log(alphaBG2) + log(prior_BG);
        if proBG  > proFG
            block64(row,col) = 0;
        end
    end
end
