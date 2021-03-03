function [MFull, PSF, I, voxelSize] = runNeuron3D(neuron, optics, zSize)
    % RUNNEURON3D
    %
    % Description:
    %   Run 3D system resolution comparison
    %
    % Syntax:
    %   [MFull, PSF, I, voxelSize] = runNeuron3D(neuron, optics)
    %
    % See also:
    %   RUNNEURON2D
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
    fprintf('source size = %.2f, %.2f microns\n',... 
        diff(xBound), diff(yBound));
    figPos(ax.Parent, 1.5, 1.5);
    
    % Divide the neuron axial into discrete sections
    zBound = ax.ZLim;
    zCount = ceil(abs(diff(zBound)) / zSize);
    
    MFull = [];
    for i = 1:zCount
        ax.ZLim = [zBound(1) + ((i-1) * zSize), zBound(1)+(i*zSize)];
        f = getframe(ax);
        M = squeeze(im2double(f.cdata(:,:,1)));
        % Voxel size should stay consistent with each section
        voxelSize = diff(xBound) / min(size(M));
        if size(M, 1) ~= size(M, 2)
            M = M(1:min(size(M)), 1:min(size(M)));
        end
        MFull = cat(3, MFull, M);
    end

    % Get the PSF
    sx = floor(3 / voxelSize); 
    sz = floor(70 / zSize);
    PSF = optics.getPSF3D(...
        (-sx*voxelSize : voxelSize : sx*voxelSize),...
        (-sx*voxelSize : voxelSize : sx*voxelSize),...
        (-sz*zSize : zSize : sz*zSize));

    figure(); 
    subplot(2, 1, 1);
    myimagesc(mean(PSF, 3));
    colormap(pink);
    figPos(gcf, 0.5, 1);
    title(sprintf('%s - PSF', optics.systemName));
    set(gca, 'FontSize', 12);
    subplot(2, 1, 2);
    h = myimagesc(squeeze(mean(PSF, 2)));
    set(h, 'YData', -sx*voxelSize : voxelSize : sx*voxelSize,...
        'XData', -sz*zSize : zSize : sz*zSize);
    drawnow;

    % Get the image
    I = convn(MFull, PSF, 'same');

    % Return 3D projection to normal size and axis range
    figPos(ax.Parent, 0.5, 0.5);
    axis(ax, 'tight');