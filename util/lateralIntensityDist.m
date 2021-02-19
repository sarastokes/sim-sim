function [v, dist] = lateralIntensityDist(r, varargin)
    % LATERALINTENSITYDIST
    %
    % Description:
    %   Get lateral focal-field intensity distribution
    %
    % Syntax:
    %   [v, dist] = lateralIntensityDist(r, varargin)
    %
    % History:
    %   19Feb2021 - SSP
    % ---------------------------------------------------------------------
    
    v = lateralOU(r, varargin{:});
    dist = abs(2 * besselj(1, v) ./ v).^2;

    % No value computed for v=0 so remove
    dist(v == 0) = [];
    v(v == 0) = [];