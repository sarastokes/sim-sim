function v = lateralOU(r, varargin)
    % LATERALOU
    %
    % Description:
    %   Lateral coordinate of optical units
    %
    % Syntax:
    %   v = lateralOU(r, varargin)
    %
    % Inputs:
    %   r           radial distance
    %
    % Optional key-value inputs:
    %   wl          wavelength
    %   NA          numerical aperture
    %
    % History:
    %   19Feb2021 - SSP
    % ---------------------------------------------------------------------

    [wl, NA] = parseParameters(varargin{:});
    v = 2 * pi / wl * NA * r;
