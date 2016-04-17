clear;close all;hfig = figure(21); hfig.Position = [488 333 642 429]; 
norm = 1; %normalized? 
suffix = 'demoPOS'; %POS files suffix
hfig.PaperPosition = [0 0 8.5 8.5*2/3]; 
factor_list = linspace(20, 150, 20);

c = colormap(cool(5)); iter = 1;
for m = [8^2 10^2 13^2 15^2 17^2]
    for NO_changed = [4]
        file_list = dir(sprintf('ProbOfSuccess/*seed_*m_%d*_NOChanged_%d_*%s.mat',m,NO_changed,suffix));
        file_list = {file_list.name};
        
        suc = zeros(1,length(factor_list));
        for file = file_list
            load(sprintf('ProbOfSuccess/%s',file{1}));
            %             file
            %             SUCCESS
            suc = suc + SUCCESS;
        end
        markers = factor_list;
        if ~norm
            markers = markers * log(m);
        end
        plot(markers, suc/length(file_list), 'o-','linewidth',3, 'markersize', 12, 'color', c(iter,:)',...
            'Displayname', sprintf('$m = %d, d = %d$',m, NO_changed)); hold on;
        
        length(file_list)
        iter = iter + 1;
    end
end
h = gca; h.FontSize = 25; grid on; axis normal; h.GridAlpha = .5;
NumTicks = 6; L = get(h,'XLim'); set(gca,'XTick',linspace(L(1),L(2),NumTicks));
h = legend('toggle');
h.Interpreter='latex'; h.FontSize = 25; h.Location = 'northwest';
ylabel('Probability of Success');
if norm
    h = xlabel('$n_p/\log(m)$');
else
    h = xlabel('$n_p$');
end
h.Interpreter = 'latex'; drawnow
print(sprintf('%s_norm_%d',suffix,norm),'-dpng')