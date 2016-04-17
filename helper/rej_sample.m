function [x] = rej_sample(mean,cov,n)
x = [];
while(size(x,2)<n)
    t = mvnrnd(mean, cov, n)';
    d = sqrt(sum(t.^2,1));
    x = [x t(:,d<15)];
    size(x,2)
end
x = x(:,1:n);
x = x';
end