function [I, v] = lateralIntensityDist(r, microscopeType, varargin)
    % LATERALINTENSITYDIST
    %
    % Description:
    %   Get lateral focal-field intensity distribution
    %
    % Syntax:
    %   [I, v] = lateralIntensityDist(r, varargin)
    %
    % History:
    %   19Feb2021 - SSP
    %   20Feb2021 - SSP - added confocal
    % ---------------------------------------------------------------------
    
    
    v = lateralOU(r, varargin{:});

    % No value computed for v=0 so make small number
    v(v == 0) = eps;
    
    if strcmp(microscopeType, 'conv')
        I = abs(2 * besselj(1, v) ./ v) .^ 2;
    else
        I = abs(2 * besselj(1, v) ./ v) .^ 4;
    end
