function y_ksi = data_generation_for_separation(un, ksi, system_response)
c = floor(length(un)/2);
mu = length(ksi);
u_ksi = zeros(size(un, 1), c*mu);
for j = 1: mu
    u_ksi(:, (j-1)*c + 1: j*c) = un(:, c+1: 2*c);
    u_ksi(ksi{j}, (j-1)*c + 1: j*c) = un(ksi{j}, 1:c);
end
y_ksi = system_response(u_ksi);
end