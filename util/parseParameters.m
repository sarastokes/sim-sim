function [wl, NA, n] = parseParameters(varargin)
    % PARSEPARAMETERS
    %
    % Description:
    %   Standard parameter parsing common to many functions
    %
    % Syntax:
    %   [wl, NA, n] = parseParameters(varargin)
    %
    % History:
    %   19Feb2021 - SSP
    % ---------------------------------------------------------------------

    ip = inputParser();
    ip.CaseSensitive = false;
    ip.KeepUnmatched = true;
    addParameter(ip, 'wavelength', assumptions('wl'), @isnumeric);
    addParameter(ip, 'NA', assumptions('na'), @isnumeric);
    addParameter(ip, 'n', assumptions('n'), @isnumeric);
    parse(ip, varargin{:});

    wl = ip.Results.wavelength;
    NA = ip.Results.NA;
    n = ip.Results.n;
