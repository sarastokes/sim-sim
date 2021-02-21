function [I, v] = axialIntensityDist(z, microscopeType, varargin)
    % AXIALINTENSITYDIST
    %
    % Description:
    %   Get intensity distribution along the optical axis
    %
    % Syntax:
    %   [I, v] = axialIntensityDist(z, microscopeType, varargin)
    %
    % History:
    %   19Feb2021 - SSP
    %   20Feb2021 - SSP - Added confocal 
    % ---------------------------------------------------------------------

    u = axialOU(z, varargin{:});
    if strcmp(microscopeType, 'conv')
        I = (sin(u / 4) ./ (u / 4)) .^ 2;
    else
        I = (sin(u / 4) ./ (u / 4)) .^ 4;
    end
