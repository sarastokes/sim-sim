function u = axialOU(z, varargin)
    % AXIALOU
    %
    % Description:
    %   Lateral coordinate of optical units
    %
    % Syntax:
    %   u = axialOU(r, varargin)
    %
    % Inputs:
    %   z           distance relative to focal point
    %
    % Optional key-value inputs:
    %   wl          wavelength
    %   NA          numerical aperture
    %
    % History:
    %   19Feb2021 - SSP
    % ---------------------------------------------------------------------

    [wl, NA, n] = parseParameters(varargin{:});
    u = (2 * pi / wl) * (NA^2 / n) * z;
