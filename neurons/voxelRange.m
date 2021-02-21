function [x, y, z] = voxelRange(neuron, voxelSize)
    % VOXELRANGE
    %
    % Description:
    %   Split the area within a bounding box into voxels of a specific size
    % 
    % Syntax:
    %   [x, y, z] = voxelRange(neuron, voxelSize)
    %
    % History:
    %   9Feb2021 - SSP
    % ---------------------------------------------------------------------

    boundingBox = voxelBox(neuron, voxelSize);
    
    x = boundingBox(1,1):voxelSize(1):boundingBox(1,2);
    y = boundingBox(2,1):voxelSize(2):boundingBox(2,2);
    z = boundingBox(3,1):voxelSize(3):boundingBox(3,2);
