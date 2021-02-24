function I = psf3d(microscopeType, x, y, z, varargin)

    if isempty(y)
        y = x;
    end

    [xx, yy] = meshgrid(x, y);
    r = sqrt(xx.^2 + yy.^2);
    Ix = lateralIntensityDist(r, microscopeType, varargin{:});

    Iz = axialIntensityDist(z, microscopeType, varargin{:});
    
    % TODO: optimize
    % I = repmat(Ix, [1 1 numel(z)]);
    I = zeros(numel(x), numel(y), numel(z));
    for i = 1:numel(z)
        I(:, :, i) = Iz(i) * Ix;
    end
    
    I = I / max(I(:));

