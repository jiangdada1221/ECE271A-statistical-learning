BG_m = containers.Map();
BG_s = containers.Map();
BG_p = containers.Map();
FG_m = containers.Map();
FG_s = containers.Map();
FG_p = containers.Map();
%%train BG
for i = 1:5
    index = num2str(i);
    [mu,sigma,pi] = train_EM(BG,C,5000);
    BG_m(index) = mu;
    BG_s(index) = sigma;
    BG_p(index) = pi;
end

%train FG
for i = 1:5
    index = num2str(i);
    [mu,sigma,pi] = train_EM(FG,C,5000);
    FG_m(index) = mu;
    FG_s(index) = sigma;
    FG_p(index) = pi;
end

di = [1,2,4,8,16,24,32,40,48,56,64];
q1 = zeros(5,11,5);
for i_FG = 1:5
    fill = zeros(5,11);
    idFG = num2str(i_FG);
    for i_BG = 1:5
        fill2 = zeros(1,11);
        idBG = num2str(i_BG);
        for i = 1:length(di)
            fill2(i) = hw5(BG_m(idBG),FG_m(idFG),BG_s(idBG),FG_s(idFG),...
                BG_p(idBG),FG_p(idFG),zigzags,di(i));
        end
        fill(i_BG,:) = fill2;
    end
    q1(:,:,i_FG) = fill;
end
