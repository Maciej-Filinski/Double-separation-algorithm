function DC = distance_correlation_separation(Un, Yn, p, q, d)
addpath('./FaDCov');
DC = zeros(p, q);
N = length(Yn);
DC_lambda = zeros(1, d+1);
for kappa = 1: q
    for eta = 1: p
        for lambda = 1: d + 1
            I_lambda = lambda: d + 1: N;
            DC_delay = zeros(1, lambda);
            for i = 1: lambda
                I_lambda_2 = lambda - i + 1: d + 1: N;
                DC_delay(1, i) = FaDCor(Un(eta, I_lambda_2)', Yn(kappa, I_lambda)');
            end
            DC_lambda(1, lambda) = max(DC_delay);
        end
        DC(eta, kappa) = max(DC_lambda);
    end
end
rmpath('./FaDCov');
end