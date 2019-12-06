function h=E_step(X,mu,sigma,pi)

%mu: C * d
%sigma: d * d * c
%pi: 1*C
%X: N * d

C = size(mu,1);
N = size(X,1);
d = size(X,2);
h = zeros(N,C);


for col=1:C
    mu_col = mu(col,:);
    sigma_col = sigma(:,:,col);
    h(:,col) = mvnpdf(X,mu_col,sigma_col);
    h(:,col) = h(:,col) * pi(col);
end

h = h ./ sum(h,2);

end