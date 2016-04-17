function [x] = randomMVNRej(seed,d,n,adj_nu,adj_de,type,npn)

change = [];
Theta = zeros(d,d);
change =  logical(adj_de - adj_nu); 
NO_change = sum(change(:))/2;

if strcmp(type,'nu')
    rng(seed);
    adj = adj_nu;
    Theta(change) = .4;
else
    rng(seed+1);
    adj = adj_de;
    Theta(change) = -.4;
end

Theta(adj==1) = .4;

Theta = Theta + eye(d,d)*2;
% x = mvnrnd(zeros(1,d), inv(Theta), n);
x = rej_sample(zeros(1,d), inv(Theta), n);
% x = rmvnrnd(zeros(1,d), inv(Theta), n, [-eye(d); eye(d)], [ones(d,1)*5;ones(d,1)*5]);
% x = rmvnrnd(zeros(1,d), inv(Theta), n, [-eye(d); eye(d)], [ones(d,1)*100;ones(d,1)*100]);

if npn
    x = sign(x).*power(abs(x),1/2);
end

end