data = load('TrainingSamplesDCT_8_new.mat');
dataFG = data.TrainsampleDCT_FG;
dataBG = data.TrainsampleDCT_BG;


%%%process FG datas
[rowsFG,colsFG]=size(dataFG);
muFG = sum(dataFG) / rowsFG;
muFG = muFG';
dataFGC = dataFG;
dataBGC = dataBG;
for i = 1:64
    dataFGC(:,i) = dataFGC(:,i) - muFG(i);
    dataBGC(:,i) = dataBGC(:,i) - muBG(i);
end
dataFGC = dataFGC .^2;
dataBGC = dataBGC .^2;
sigmaFG = sum(dataFGC)/rowsFG;
sigmaFG = sqrt(sigmaFG);
sigmaFG = sigmaFG';


%%%% process BG datas
[rowsBG,colsBG] = size(dataBG);
muBG = sum(dataBG) / rowsBG;
muBG = muBG';
sigmaBG = sum(dataBGC)/rowsBG;
sigmaBG = sqrt(sigmaBG);
sigmaBG = sigmaBG';
sigmaBG = sigmaBG';
CovFG = cov(dataFG);
CovBG = cov(dataBG);

%  i = 1
%     subplot(8,8,i);
%     alphaFG = 1 / sqrt((2*pi)^64 * det(CovFG));
%
%     alphaBG = 1 / sqrt(2*pi*det(CovBG));
%     minR = min(muFG(i),muBG(i));
%     maxR = max(muFG(i),muBG(i));
%     rangeMin = minR - (minR + maxR)/2;
%     rangeMax = maxR + (minR + maxR)/2;
%     x = rangeMin : 0.1 : rangeMax;
%     num = length(x);
%     array = ones(num,64); % numX * 64
%     array = array .* (x');   % numX*64  X numX* 1
%     size(array); % numX * 64
%     y = ones(1,num);   % 1 * numX
%     for j = 1:num
%         arrayFG = [array(j,:) ; dataFG(2:250,:)]; % 250 * 64
%         sumFG = 0;
%         for h=1:250
%             sumFG =sumFG + alphaFG * exp(-0.5*(arrayFG(h,:)'-muFG)' * inv(CovFG) * (arrayFG(h,:)'-muFG));
%         end
%
%         y(j) = sumFG;
%     end
%     plot(x,y);
%



figure;
 for i = 1:64
    subplot(8,8,i);
    rangeMax = max([muFG(i),muBG(i)]) ;
    rangeMin = min([muFG(i),muBG(i)]) ;
%     x = -0.05 : 0.001 : 0.05;
    x = rangeMin - 4 * sigmaFG(i):0.001:rangeMax+4*sigmaFG(i);
    pFG = 1/(sqrt(pi*2)*sigmaFG(i)) * exp(-(x - muFG(i))^2/(2*sigmaFG(i)^2));

    pBG = 1/(sqrt(pi*2)*sigmaBG(i)) * exp(-(x - muBG(i))^2/(2*sigmaBG(i)^2));
    plot(x,pFG,'r');


    hold on;
    plot(x,pBG,'b');
    title(i);
    hold off;
%     axis([rangeMin * 0.5 rangeMax*1.5 0 ymax]);
 end
%  figure;
% for i = 1:64
%     subplot(8,8,i);
%     plot(muFG(i),5,'rx');
%     hold on;
%     plot(muBG(i),5,'rx');
%     hold off;
% end

figure;
%%%plot the 8-best feature  1 2 3 4 5 50 57 58
indexs = [1 2 3 4 5 50 57 58];
for j = 1:8
  subplot(2,4,j);
  i = indexs(j);
  rangeMax = max([muFG(i),muBG(i)]) ;
  rangeMin = min([muFG(i),muBG(i)]) ;
  x = rangeMin - 4 * sigmaFG(i):0.001:rangeMax+4*sigmaFG(i);
  pFG = 1/(sqrt(pi*2)*sigmaFG(i)) * exp(-(x - muFG(i))^2/(2*sigmaFG(i)^2));
  pBG = 1/(sqrt(pi*2)*sigmaBG(i)) * exp(-(x - muBG(i))^2/(2*sigmaBG(i)^2));
  plot(x,pFG,'r');
  hold on;
  plot(x,pBG,'b');
  title(i);
  hold off;
end

figure;
%%%%plot the 8-worst feature
indexs = [7 9 13 15 63 18 37 19]
for j = 1:8
  subplot(2,4,j);
  i = indexs(j);
  rangeMax = max([muFG(i),muBG(i)]) ;
  rangeMin = min([muFG(i),muBG(i)]) ;
  x = rangeMin - 4 * sigmaFG(i):0.001:rangeMax+4*sigmaFG(i);
  pFG = 1/(sqrt(pi*2)*sigmaFG(i)) * exp(-(x - muFG(i))^2/(2*sigmaFG(i)^2));
  pBG = 1/(sqrt(pi*2)*sigmaBG(i)) * exp(-(x - muBG(i))^2/(2*sigmaBG(i)^2));
  plot(x,pFG,'r');
  hold on;
  plot(x,pBG,'b');
  title(i);
  hold off;
end
