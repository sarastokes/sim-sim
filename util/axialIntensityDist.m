function [u, dist] = axialIntensityDist(z, varargin)
    % AXIALINTENSITYDIST
    %
    % Description:
    %   Get axial focal-field intensity distribution
    %
    % Syntax:
    %   [u, dist] = axialIntensityDist(z, varargin)
    %
    % History:
    %   19Feb2021 - SSP
    % ---------------------------------------------------------------------

    u = axialOU(z, varargin{:});
    dist = (sin(u / 4) ./ (u / 4)) .^ 2;