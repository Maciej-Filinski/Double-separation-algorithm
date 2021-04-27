function DC = distance_correlation_separation(Un, Yn, p, q, d)
addpath('./FaDCov');
DC = zeros(p, q);
N = length(Yn);
DC_lambda = zeros(1, d+1);
for kappa = 1: q
    for eta = 1: p
        for lambda = 1: d + 1
            I_lambda = lambda: d + 1: N;
            DC_lambda(1, lambda) = FaDCor(Un(eta, I_lambda)', Yn(kappa, I_lambda)');
        end
        DC(eta, kappa) = max(DC_lambda);
    end
end
rmpath('./FaDCov');
end