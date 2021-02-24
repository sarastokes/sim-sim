function I = psf2d(microscopeType, x, y, varargin)
    % PSF2D
    %
    % Syntax:
    %   I = psf2d(microscopeType, x, y, varargin)
    %
    % See also:
    %   lateralIntensityDist
    %
    % History:
    %   21Feb2021 - SSP
    % ---------------------------------------------------------------------

    if nargin < 3 || isempty(y)
        y = x;
    end

    [xx, yy] = meshgrid(x, y);
    r = sqrt(xx.^2 + yy.^2);
    I = lateralIntensityDist(r, microscopeType, varargin{:});

    I = I / max(I(:));
