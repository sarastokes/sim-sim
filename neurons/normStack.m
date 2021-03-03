function normStack(I)
    % NORMSTACK
    for i = 1:size(I, 3)
        I(:, :, i) = I(:, :, i) - min(min(I(:, :, i)));
        I(:, :, i) = I(:, :, i) / max(max(I(:, :, i)));
        I(:, :, i) = abs(1 - I(:, :, i));
    end