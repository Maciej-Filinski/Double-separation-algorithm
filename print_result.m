function print_result(N, S, var_e, DC, threshold)
close all;
figure('units','normalized','outerposition',[0 0 1 0.6]);
for i = 1: 3
    subplot(1, 3, i); hold on; grid on;
    plot(ones(1, N(end))*var_e);
    plot(N, S{i,1},'LineWidth',2);
    plot(N, S{i,2},'LineWidth',2);
    plot(N, S{i,3},'LineWidth',2);
    plot(N, S{i,4},'LineWidth',2);
    set(gca,'FontSize',25);
    set(gca,'TickLabelInterpreter','latex')
    legend('$$\sigma_e^2$$', '$$\hat{\xi}_1^\kappa$$', '$$\hat{\xi}_2^\kappa$$', '$$\hat{\xi}_3^\kappa$$', '$$\hat{\xi}_4^\kappa$$', 'Interpreter', 'latex','FontSize',20);
    if i == 1
    ylabel('$$\bar{S}(\hat{\xi}_i^\kappa)$$', 'Interpreter', 'latex', 'FontSize', 30);
    end
    xlabel('$$\lfloor N/2 \rfloor$$', 'Interpreter', 'latex');
    if i==1 || i == 2
        ylim([-20, 100]);
    else
        ylim([-20*10^5, 30*10^5]);
    end
    xlim([20, N(end)]);
end
figure('units','normalized','outerposition',[0 0 0.20 0.22]);
    plot(ones(1, N(end))*var_e); hold on; grid on;
    plot(N, S{3,1});
    set(gca,'FontSize',10);
    ylim([0, 600]);
    xlim([20, 3.5*10^4]);
    legend('$$\sigma_e^2$$', '$$\hat{\xi}_1^\kappa$$', 'Interpreter', 'latex','FontSize',10);
% figure();
% for i = 1: 3
%     subplot(1, 3, i); hold on; grid on;
%     plot(ones(1, N(end))*var_e);
%     plot(N, S{i,1});
%     plot(N, S{i,2});
%     plot(N, S{i,3});
%     plot(N, S{i,4});
%     set(gca,'FontSize',20)
%     legend('$$\sigma_e^2$$', '$$\hat{\xi}_1^\kappa$$', '$$\hat{\xi}_2^\kappa$$', '$$\hat{\xi}_3^\kappa$$', '$$\hat{\xi}_4^\kappa$$', 'Interpreter', 'latex');
%     if i == 1
%     ylabel('$$\hat{S}$$', 'Interpreter', 'latex', 'FontSize', 40);
%     end
%     xlabel('$$\lfloor N/2 \rfloor$$', 'Interpreter', 'latex');
%     title_sub = join(['\kappa = ', int2str(i)], '');
%     title(title_sub);
%     xlim([N(1000), N(end)]);
% end

figure('units','normalized','outerposition',[0 0 0.5 0.5]);

bar(DC); grid on;
yline(threshold, 'k--');
set(gca,'TickLabelInterpreter','latex')
xlabel('\eta');
ylabel('$$\hat{DC}(\eta,\kappa)$$', 'Interpreter', 'latex');
set(gca,'FontSize',15)
legend('$$\kappa = 1$$', '$$\kappa = 2$$', '$$\kappa = 3$$', 'threshold', 'Interpreter', 'latex','FontSize',15);

end