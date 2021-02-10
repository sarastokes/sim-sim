function proj = maxProj(vol, plotme)

    if nargin < 2
        plotme = false;
    end

    proj = squeeze(sum(vol, 3));

    if plotme
        figure();
        imagesc(proj);
        axis equal tight
        colorbar();
        colormap(pink(max(max(proj)) + 1));
    end