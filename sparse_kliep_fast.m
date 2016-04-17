function [Delta, theta] = sparse_kliep_fast(xp, xq, lambda, theta, kp, kq)
m = size(xp,1);
if nargin<5
    kp = kernel_linear(xp); kq = kernel_linear(xq);
end
if nargin<4 || isempty(theta)
    theta = sparse(zeros(size(kq,1),1));
end

%% Naive subgradient descent
tic
step = 1; slength = inf; iter = 0; fold = inf; sparsity= ones(size(theta));
while(slength > 1e-5)
    [f, gt] = LLKLIEP(theta,kp,kq);
    g = zeros(size(gt));
    
    id = abs(theta)>0;
    g(id) = gt(id) + lambda*sign(theta(id));
    id = theta==0 & gt > lambda;
    g(id) = gt(id) - lambda;
    id = theta==0 & gt < -lambda;
    g(id) = gt(id) + lambda;
    theta = theta - step*g./(iter+1);
    slength = step*norm(g)./(iter+1);
    fdiff = abs(f - fold);
    %display some stuffs
    if iter > 1000
        disp('max iteration reached.')
        break;
    else
        iter = iter+1;
        fdiff = abs(f - fold);
        fold = f;
        if ~mod(iter,100)
            disp(sprintf('%d, %.5f, %.5f, %.5f, nz: %d',...
                iter, slength,fdiff,full(fold),sum(theta(1:end-m)~=0)))
        end
        if ~mod(iter,20) && iter ~=0
            if sum(double(theta ~= 0) - sparsity) == 0
                disp('sparsity has not changed for 20 iters')
                break;
            end
            sparsity = double(theta ~= 0);
        end
    end
end
toc

% generate differential matrix
tt = ones(m); tt = triu(tt,1); tt=tt(:); idx = tt~=0;
Delta = zeros(1,m*m);
Delta(idx) = theta(1:end-m); Delta = reshape(Delta,m,m);
Delta = Delta + Delta';

end