function S_kappa = separability_factor(yn, yksi, d)
c = length(yksi);
c1 = floor(length(yn)/2);
mu = 2;
S_ksi = zeros(1, d+1);
for i =1:d+1 % for all lambda
    S_lambda = d+1+i-1:d+1:c;
    
    S1_lambda = 1/length(S_lambda)*sum(yn(S_lambda).*(yn(S_lambda)+(mu-1)*yn(S_lambda+c1)));
    S2_lambda = 1/length(S_lambda)*sum(sum(yn(S_lambda).*yksi(:, S_lambda)));
    
    S_ksi(i) = S1_lambda - S2_lambda;
end
S_kappa = mean(S_ksi);
end 
