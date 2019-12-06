function [mu0,sigma0,pi0] = train_EM(X,C,max_iter)

% X : N * d
% h : N * C
% pi : C
%mu: C*d
%sigma: d*d*C
N = size(X,1);
d = size(X,2);   


mu0 = zeros(C,d);
sigma0 = zeros(d,d,C);
indexs = randi(N,1,C);
for i = 1:C
    sigma0(:,:,i) = diag(ones(1,d) .* rand(1,d)+1e-5);
    mu0(i,:) = X(indexs(i),:) ;
end
pi0 = ones(1,C) / C;
prev_mu = mu0(:,1);
for i = 1:max_iter
    h = E_step(X,mu0,sigma0,pi0);
    [mu0,sigma0,pi0] = M_step(X,h,mu0);
    if sum(abs((mu0(:,1) - prev_mu) ./ prev_mu)) < 0.01
        break;
    end
end
end