%%Solution for problem 2
BG_m2 = containers.Map();
BG_s2 = containers.Map();
BG_p2 = containers.Map();
FG_m2 = containers.Map();
FG_s2 = containers.Map();
FG_p2 = containers.Map();
C_values = [1,2,4,8,16,32];
% train BG

for i = 1:length(C_values)
    index = num2str(i);
    [mu,sigma,pi] = train_EM(BG,C_values(i),5000);  %%check em strps
%     [mu,sigma,pi] = train_EM(BG,32,250);
    BG_m2(index) = mu;
    BG_s2(index) = sigma;
    BG_p2(index) = pi;
end

for i = 1:length(C_values)
    index = num2str(i);
    [mu2,sigma2,pi2] = train_EM(FG,C_values(i),5000);  %%check em strps
% [mu2,sigma2,pi2] = train_EM(FG,32,250); 
    FG_m2(index) = mu2;
    FG_s2(index) = sigma2;
    FG_p2(index) = pi2;
end

di = [1,2,4,8,16,24,32,40,48,56,64];
q4 = zeros(6,11);
for i = 1:length(C_values)%classifier
    id = num2str(i);
    for j = 1:length(di)% points
        q4(i,j) = hw5(BG_m2(id),FG_m2(id),BG_s2(id),FG_s2(id),...
                BG_p2(id),FG_p2(id),zigzags,di(j));
    end
end
