function subsets = create_powerset(set)
n = length(set);
bin_set = de2bi(0:2^n-1);
subset = bin_set.*set;
subsets = cell(1, 2^n);
for i = 1: 2^n
    tmp = subset(i, :);
    tmp(tmp == 0) = [];
    subsets{i} = tmp;
end
end

