function P = set_difference(P, Subset)
for i=1:length(P)
    if isempty(Subset)
        if isempty(P{i})
            P(i) = [];
            break
        end
    else
        if length(P{i}) == length(Subset) & P{i} == Subset %#ok<AND2>
            P(i) = [];
            break
        end
    end
end
end
