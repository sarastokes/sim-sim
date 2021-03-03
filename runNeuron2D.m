function runNeuron2D(neuron, optics)
    % RUNNEURON2D
    %
    % Description:
    %   Run 2D system resolution comparison
    %
    % Syntax:
    %   runNeuron2D(neuron, optics)
    %
    % See also:
    %   RUNNEURON3D
    %
    % History
    %   21Feb2021 - SSP
    % ---------------------------------------------------------------------

    % Render a 2D projection of the neuron as solid w/ no lighting
    ax = golgi(neuron);
    set(findobj(ax, 'Tag', ['c', num2str(neuron.ID)]), 'FaceAlpha', 1);

    % Control pixel size to conserve accuracy of micron conversion
    equalSpanAxes(ax);
    xBound = ax.XLim; yBound = ax.YLim;
    fprintf('source size = %.2f, %.2f microns\n', diff(xBound), diff(yBound));
    figPos(ax.Parent, 1.5, 1.5);

    % Convert 2D projection to 2D array
    f = getframe(ax);
    M = squeeze(im2double(f.cdata(:,:,1)));
    voxelSize = diff(xBound) / min(size(M));
    fprintf('voxelSize = %.4g microns\n', voxelSize);

    if size(M, 1) ~= size(M, 2)
       warning('RUNNEURON2D: Removed %u voxels', diff(size(M)));
       M = M(1:min(size(M)), 1:min(size(M)));
    end

    % Get the PSF
    s = floor(3 / voxelSize); 
    PSF = optics.getPSF2D(...
        (-s*voxelSize : voxelSize : s*voxelSize),...
        (-s*voxelSize : voxelSize : s*voxelSize));

    figure(); myimagesc(PSF);
    colormap(pink);
    figPos(gcf, 0.5, 0.5);
    title(sprintf('%s - PSF', optics.systemName));
    set(gca, 'FontSize', 12);


    % Get the image
    I = conv2(M, PSF, 'same');
    
    % Scale by nyquist limit
    resizeFac = voxelSize(1) / optics.minVoxel(1);
    figure(); myimagesc(imresize(I, resizeFac));
    colormap(flipud(gray));
    title(sprintf('%s - nyquist: %.3f (%u x %u pix)',... 
        optics.systemName, optics.minVoxel(1), size(imresize(I, resizeFac))));
    set(gca, 'FontSize', 12);
    tightfig(gcf);

    % Scale by specific fields of view
    resizeFac = voxelSize(1) / fovPixelSize(0.96);
    figure(); myimagesc(imresize(I, resizeFac));
    colormap(flipud(gray));
    title(sprintf('%s - 0.96 degree FOV (%u pix)',...
        optics.systemName, size(imresize(I, resizeFac), 1)));
    set(gca, 'FontSize', 12);
    tightfig(gcf);

    resizeFac = voxelSize(1) / fovPixelSize(1.92);
    figure(); myimagesc(imresize(I, resizeFac));
    colormap(flipud(gray));
    title(sprintf('%s - 1.92 degree FOV (%u pix)',...
        optics.systemName, size(imresize(I, resizeFac), 1)));
    set(gca, 'FontSize', 12);
    tightfig(gcf);

    % Return 3D projection to normal size
    figPos(ax.Parent, 0.5, 0.5);
    axis(ax, 'tight');