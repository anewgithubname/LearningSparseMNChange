addpath(genpath('helper')); mkdir ProbOfSuccess
factor_list = linspace(20, 150, 20); seed_list = 1:300;
tic
for m = [8^2 10^2 13^2 15^2 17^2]
    NO_changed = 4;
    parfor seed = seed_list
        rng(seed); seed
        
        adj_nu = FourNeighbors(sqrt(m),0); adj_de = FourNeighbors(sqrt(m),NO_changed);
        Delta = logical(adj_nu - adj_de);
        figure('visible','off'); spy(adj_nu- adj_de)
        
        theta_init = [];
        SUCCESS = [];
        for factor = factor_list
            np = round(factor*log(m)), nq = np, m
            [xp] = randomMVNRej(seed,m,np+0,adj_nu,adj_de,'nu',false)';
            [xq] = randomMVNRej(1,m,nq+0,adj_nu,adj_de,'de',false)';
            lambda= 2.5 * sqrt(log(m)/np),factor
            
            flag = false;
            clk = clock;
            reg_path = [];
            
            tic
            %% compute the regularization path
            display(sprintf('lambda2:%f',lambda))
            [Delta_hat, theta_hat] = sparse_kliep_fast(xp, xq, lambda, theta_init);
            theta_init = theta_hat;
            Delta_hat = abs(Delta_hat(:));
            reg_path = [reg_path, Delta_hat];
            np
            %testing if we get the correct pattern
            figure(99);clf;plot(Delta_hat);
            hold on;plot(find(Delta(:)),abs(Delta_hat(Delta(:))),'ro')
            
            if(all(Delta_hat(Delta(:))~=0) & all(Delta_hat(~Delta(:))==0))
                display('success!')
                flag = true;
            end
            elapsed_time = toc;
            display(sprintf('total elapsed time: %.2f', elapsed_time))
            
            SUCCESS = [SUCCESS, flag];
        end
        %note the POS files are ended with a suffix 'demoPOS'
        parsave(sprintf('ProbOfSuccess/suc_seed_%d_m_%d_NOChanged_%d_demoPOS',seed,m,NO_changed),...
            SUCCESS,m,factor_list);
    end
end
toc