function [dx, dz] = nyquistSampleDistance(microscopeType, varargin)
    % NYQUISTSAMPLEDISTANCE
    %
    % Description:
    %   Compute the Nyquist critical sampling distance 
    %
    % Syntax:
    %   [dx, dy] = nyquistSampleDistance(microscopeType, varargin)
    %
    % Reference:
    %   https://svi.nl/NyquistRate 
    % ---------------------------------------------------------------------

    [wl, NA, n] = parseParameters(varargin{:});

    a = halfApertureAngle(NA, n);
    dx = wl / (4 * n * sin(a));
    dz = wl / (2 * n * (1 - cos(a)));

    if strcmp(microscopeType, 'conf')
        dx = dx / 2;
        dz = dz / 2;
    end