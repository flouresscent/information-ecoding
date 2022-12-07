function entropy = entropy(s)
    [~, probs] = alphabet_probabilities(s);
    entropy = -sum(probs.*log2(probs));
end

