function Yn = real_system_response(Un, sigma_e2, d)
% d - memory length
% p - number of inputs
% Yn - output sequence
% Un - input sequence
% q - number of outputs
% N - number of sample
p = size(Un, 1);
q = 3; 
N = length(Un); 
Yn = zeros(q, N);
c = 1;
Un = c*4*(2*Un - 1);
%%% dynamic block %%%
for i = 1: p
    Vn{i} = Un(i, :);
%     Vn{i} = [];
    ith_memory = Un(i, :);
    for j = 1: d
        ith_memory = [rand(1), ith_memory(:, 1: end-1)];
        Vn{i} = [Vn{i}; ith_memory];
    end
end

%%% nonlinear block %%%
% first output: D_1 = {1, 2, 3}, separable ksi = {{1}, {2}, {3}}
Yn(1, :) = sum(Vn{1} + 1, 1).^2 + sum(Vn{2} + 1, 1).^2 + sum(Vn{3} + 1, 1).^2;
% second output: D_2 = {4, 6, 8}, separable ksi = {{4, 6}, {8}}
Yn(2, :) = 10*atan(sum(Vn{4} + Vn{6}, 1)) + sum(Vn{8}.^2, 1);
% third output: D_3 = {5, 6, 7}, separable ksi = {{5, 6, 7}}
Yn(3, :) = (sum(Vn{5}.^2 + Vn{6}.^2 + Vn{7}.^2, 1)).^2;
%%% additive noise %%% 
Yn = Yn + normrnd(0, sqrt(sigma_e2), [q, N]);
end