% clear variables, close all
clc
tic
%%% system parameters %%%
d = 9;
N = 10^5;
p = 8;
q = 3;
var_e = 0.25;
system = @(un)real_system_response(un, var_e, d);

rng(3);
%%% passive experiment %%%
u_n = rand(p, N);
y_n = system(u_n);

%%% Distance correlation separation parameters %%%
alpha_0 = .04;
alpha_1 = 0;

%%% Double Separation Algorithm - DSA %%%
DC = distance_correlation_separation(u_n, y_n, p, q, d);
writematrix(DC, 'Result\Distance_correlation.csv');
DC_plot = DC;
DC = DC >= alpha_0*N^(-alpha_1);
DC_real = [1 0 0; 1 0 0; 1 0 0; 0 1 0; 0 0 1; 0 1 1; 0 0 1; 0 1 0];
if ~isequal(DC, DC_real)
    DC = DC_real;
    fprintf('DC wrong interpretation');
end
DC = [1:p]'.*DC; %#ok<NBRAK>
D_N = cell(1, q);
for kappa = 1: q
    D_N{kappa} = DC(:, kappa)';
    D_N{kappa}(D_N{kappa} == 0) = [];
    P = create_powerset(D_N{kappa});
    j = 1;
    while ~isempty(P)
        ksi{kappa, j} = {P{1}, D_N{kappa}(~ismember(D_N{kappa},P{1}))}; %#ok<SAGROW>
        P = set_difference(P, ksi{kappa, j}{1});
        P = set_difference(P, ksi{kappa, j}{2});
        y_ksi = data_generation_for_separation(u_n, ksi{kappa, j}, system);
        c = floor(N/2);
        y_ksi = [y_ksi(kappa, 1:c); y_ksi(kappa, c+1:2*c)];
        %%% calculate separability for N %%%
        S_test{kappa, j} = separability_factor(y_n(kappa, :), y_ksi, d); %#ok<SAGROW>
        
        %%% calculate separability convergence to noise variance %%%
        N_sim = [20:10:99, 100:50:990, 1000:100:c];
        N_sim = 20:1:c;
        S_tmp = zeros(1, length(N_sim));
        for i=1:length(N_sim)
            S_tmp(i) = separability_factor(y_n(kappa, :), y_ksi(:, 1: N_sim(i)), d);
        end
        writematrix(S_tmp, join(["Result\", "S_kappa=", kappa, "_j=", j, ".csv"], ""));
        S{kappa, j} = S_tmp; %#ok<SAGROW>
        j = j + 1;
    end
end
toc
print_result(N_sim, S, var_e, DC_plot, alpha_0)
