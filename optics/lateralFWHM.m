function fwhm = lateralFWHM(wl, NA, microscopeType)
    % LATERALFWHM
    %
    % Description:
    %   Theoretical lateral resolution 
    %
    % Syntax:
    %   fwhm = lateralFWHM(wl, NA, microscopeType)
    %
    % Inputs:
    %   wl                  float
    %       Wavelength
    %   NA                  float
    %       Numerical aperture (default = Gray 2008, 0.2335)
    %   microscopeType      {'conv', 'conf'}
    %       Confocal or conventional microscope? (default = 'conv')
    %
    % Reference:
    %   Eq15 in Wilson (2011) Journal of Microscopy, 244, 113-121
    %   NA from Gray et al (2008) IOVS, 49, 467-473
    %
    % History:
    %   07Feb2021 - SSP
    %   18Feb2021 - SSP - Added assumptions call rather than hard-coding
    % ---------------------------------------------------------------------

    if nargin < 3
        microscopeType = 'conv';
    end

    if nargin < 2 || isempty(NA)
        NA = assumptions('numerical aperture');  
    end

    switch microscopeType 
        case 'conv'
            fwhm = 0.51 * (wl / NA);
        case 'conf'
            fwhm = 0.37 * (wl / NA);
        otherwise
            error('Unrecognized microscope type')
    end