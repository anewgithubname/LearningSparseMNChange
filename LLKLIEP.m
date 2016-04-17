function [l,g,h] = LLKLIEP(theta,kP,kQ)
l = [];
% l = -mean(theta'*kP,2) + log(sum(exp(theta'*kQ),2));

N_q = sum(exp(theta'*kQ),2);
g_q = exp(theta'*kQ)./ N_q;
g = -mean(kP,2) + kQ*g_q';

% hessian
if nargout>2
    HH = diag(g_q) - g_q'*g_q;
    h = kQ*HH*kQ';
end
end