function T = getSimResolutions(varargin)
    % GETSIMRESOLUTIONS
    %
    % Description:
    %   Compare the resolution of the two systems 
    %
    % Syntax:
    %   T = getSimResolutions(varargin)
    %
    % History:
    %   10Feb2021 - SSP
    %   19Feb2021 - SSP - Simplified inputs and outputs
    % ---------------------------------------------------------------------

    ip = inputParser();
    ip.CaseSensitive = false;
    ip.KeepUnmatched = true;
    addParameter(ip, 'Output', 'fwhm',... 
        @(x) ismember(lower(x), {'fwhm', 'sd'}));
    parse(ip, varargin{:});

    [wl, NA, n] = parseParameters(ip.Unmatched);
    outputType = ip.Results.Output;
    fprintf('Resolution (%s) calculated with:\n', upper(outputType));
    fprintf('\twl=%u, NA=%.2f, n=%.2f\n', 1000*wl, NA, n);

    lateral1 = lateralFWHM(wl, NA, 'conv');
    axial1 = axialFWHM(wl, NA, n, 'conv');
    
    lateral2 = lateral1 / 2;
    axial2 = axialFWHM(wl, NA, n, 'conf');
    
    A = [lateral1; axial1];
    B = [lateral2; axial2];
    
    if strcmp(outputType, 'sd')
        A = fwhm2sd(A);
        B = fwhm2sd(B);
    end

    T = table(A, B,... 
        'VariableNames', {'A', 'B'},...
        'RowNames', {'lateral', 'axial'});