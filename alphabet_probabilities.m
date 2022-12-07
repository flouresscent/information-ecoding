function [syms, prbs] = alphabet_probabilities(s)
    [syms, ~, prbs_idx] = unique(s);
    prbs = accumarray(prbs_idx, 1) ./ length(s);
end

