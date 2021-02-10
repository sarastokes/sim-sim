function T = getSimResolutions(varargin)
    % GETSIMRESOLUTIONS
    %
    % Description:
    %   Utility function to compare two systems 
    %
    % Syntax:
    %   T = getSimResolutions(varargin)
    %
    % History:
    %   10Feb2021 - SSP
    % ---------------------------------------------------------------------

    ip = inputParser();
    addParameter(ip, 'wl', 0.535, @isnumeric);
    addParameter(ip, 'n', [], @isnumeric);
    addParameter(ip, 'NA', [], @isnumeric);
    addParameter(ip, 'Output', 'fwhm',... 
        @(x) ismember(lower(x), {'fwhm', 'sd'}));
    parse(ip, varargin{:});

    wl = ip.Results.wl;
    n = ip.Results.n;
    NA = ip.Results.NA;
    outputType = ip.Results.Output;

    lateral1 = lFWHM(wl, NA, 'conv');
    lateral2 = lateral1 / 2;

    axial1 = aFWHM(wl, NA, n, 'conv');
    axial2 = aFWHM(wl, NA, n, 'conf');
    
    A = [lateral1; lateral2];
    B = [axial1; axial2];
    
    if strcmp(outputType, 'sd')
        A = fwhm2sd(A);
        B = fwhm2sd(B);
    end

    T = table(A, B,... 
        'VariableNames', {'lateral', 'axial'},...
        'RowNames', {'System A', 'System B'});