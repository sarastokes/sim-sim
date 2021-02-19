function [x, y, z] = voxelRange(neuron, voxelSize)

    boundingBox = voxelBox(neuron, voxelSize);
    
    x = boundingBox(1,1):voxelSize(1):boundingBox(1,2);
    y = boundingBox(2,1):voxelSize(2):boundingBox(2,2);
    z = boundingBox(3,1):voxelSize(3):boundingBox(3,2);