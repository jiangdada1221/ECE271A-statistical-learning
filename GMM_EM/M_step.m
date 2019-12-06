function [mu,sigma,pi] = M_step(X,h,mu0)

% X : N * d
% h : N * C
% pi : C
C = size(h,2);
N = size(X,1);
d = size(X,2);
%mu: C*d
pi = sum(h) / N ;
mu = zeros(C,d);
sigma = zeros(d,d,C);

for col = 1:C
    mu(col,:) = sum(h(:,col) .* X) / (sum(h(:,col)));
    x_col = X - mu0(col,:);
    s = sum((x_col .* x_col) .* h(:,col))/(sum(h(:,col)));
    s = s+1e-10;
    sigma(:,:,col) = diag(s);
end

end