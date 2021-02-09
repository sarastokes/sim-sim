function bounds = getNeuronBounds(neuron)

    bounds = zeros(3, 2);

    xyz = neuron.getCellXYZ();
    for i = 1:3
        [bounds(i, 1), ind] = min(xyz(:, i));
        bounds(i, 1) = bounds(i, 1) - neuron.nodes.Rum(ind);

        [bounds(i, 2), ind] = max(xyz(:, i));
        bounds(i, 2) = bounds(i, 2) + neuron.nodes.Rum(ind);
    end

    