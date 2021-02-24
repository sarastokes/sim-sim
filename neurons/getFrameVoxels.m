function [voxelSize, numVoxels] = getFrameVoxels(ax)
    % GETFRAMEVOXELS
    %
    % Description:
    %   Get pixel size in microns from getframe output
    %
    % Syntax:
    %   [voxelSize, numVoxels] = getFrameVoxels(ax)
    %
    % History:
    %   21Feb2021 - SSP
    % ---------------------------------------------------------------------


    screenPixelsPerInch = java.awt.Toolkit.getDefaultToolkit().getScreenResolution();

    mpix2pix = @(x) (screenPixelsPerInch / 96) * x;

    numVoxels = mpix2pix(get(ax.Parent, 'Position'));
    numVoxels(1:2) = [];

    set(ax, 'Units', 'pixels');
    axPix =  mpix2pix(get(ax, 'Position'));
    axPix(1:2) = [];
    set(ax, 'Units', 'normalized');

    xBounds = xlim(ax);
    yBounds = ylim(ax);
    voxelSize = [diff(xBounds) / axPix(1), diff(yBounds) / axPix(2)];
