%sigma_FG,sigma_BG, mu_FG,mu_BG d 64
function [error,block64] = hw5(mu_BG,mu_FG,sigma_BG,sigma_FG,pi_BG,pi_FG,zigzags,d)
rows = 255;
cols = 270;
mu_BG = mu_BG(:,1:d);
mu_FG = mu_FG(:,1:d);
sigma_BG = sigma_BG(1:d,1:d,:);
sigma_FG = sigma_FG(1:d,1:d,:);

prior_FG = 0.1919;
prior_BG = 0.8081;

C = size(mu_BG,1);
inv_BG = zeros(d,d,C);
inv_FG = zeros(d,d,C);
alpha_BG = zeros(1,C);
alpha_FG = zeros(1,C);
for i = 1:C
    inv_BG(:,:,i) = pinv(sigma_BG(:,:,i));
    inv_FG(:,:,i) = pinv(sigma_FG(:,:,i));
%     alpha_BG(1,i) = sqrt((2*pi)^d*det(sigma_BG(:,:,i)));
%     alpha_FG(1,i) = sqrt((2*pi)^d*det(sigma_FG(:,:,i)));
    BG_log = log(diag(sigma_BG(:,:,i)));
    FG_log = log(diag(sigma_FG(:,:,i)));
    alpha_BG(1,i) = sum(BG_log);
    alpha_FG(1,i) = sum(FG_log);
end

block64 = zeros(rows,cols);
for row = 1:rows-7
    for col = 1:cols-7
        zigzag_matrix = zigzags(row,col,:);
        zigzag_matrix = zigzag_matrix(:);
        zigzag_matrix = zigzag_matrix(1:d);
        probFG = 0;probBG = 0;
        for i = 1:C
            mu_fg = mu_FG(i,:)';
            mu_bg = mu_BG(i,:)';
            x_fg = zigzag_matrix - mu_fg;
            x_bg = zigzag_matrix - mu_bg;
%             probFG = probFG + pi_FG(i)*exp(-0.5*x_fg'*inv_FG(:,:,i)*x_fg)/alpha_FG(i);
%             probBG = probBG + pi_BG(i) * exp(-0.5*x_bg'*inv_BG(:,:,i)*x_bg)/alpha_BG(i);
            F = log(pi_FG(i))-0.5*x_fg'*inv_FG(:,:,i)*x_fg - 0.5*alpha_FG(i);
            B = log(pi_BG(i))-0.5*x_bg'*inv_BG(:,:,i)*x_bg - 0.5*alpha_BG(i);
            probFG = probFG + exp(F);
            probBG = probBG + exp(B);
        end 
        probFG = log(probFG)  + log(prior_FG);
        probBG = log(probBG) + log(prior_BG);     
        if probFG >= probBG
            block64(row,col) = 1;
        end
    end
end
error = compute_error(block64);
end