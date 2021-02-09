function [boundingBox, extent] = voxelBox(neuron, voxelSize)
    
    if isempty(neuron.model)
        neuron.build();
    end

    boundingBox = getNeuronBounds(neuron);
    extent = diff(boundingBox')';

    for i = 1:3
        boundingBox(i, 2) = boundingBox(i, 2) + ... 
            (voxelSize(i) - rem(extent(i), voxelSize(i)));
    end

    extent = diff(boundingBox')';