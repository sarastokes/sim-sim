function fwhm = axialFWHM(wl, NA, n, microscopeType)
    % AXIALFWHM
    %
    % Description:
    %   Theoretical axial resolution 
    %
    % Syntax:
    %   fwhm = axialFWHM(wl, n, NA, microscopeType)
    %
    % Inputs:
    %   wl                  float
    %       Wavelength
    %   NA                  float
    %       Numerical aperture (default = Gray 2008, 0.2335)
    %   n                   float
    %       Refractive index (default = lens, 1.42)
    %   microscopeType      {'conv', 'conf'}
    %       Confocal or conventional microscope? (default = 'conv')
    %
    % Notes:
    %   Axial resolution is ~1.4x better for confocal 
    %
    % Reference:
    %   Eq16 in Wilson (2011) Journal of Microscopy, 244, 113-121
    %   NA from Gray et al (2008) IOVS, 49, 467-473
    %   n from Atchinson ch 16 in Handbook of Visual Optics
    %
    % History:
    %   07Feb2021 - SSP
    %   18Feb2021 - SSP - Added assumptions call rather than hard-coding
    % ---------------------------------------------------------------------

    if nargin < 4
        microscopeType = 'conv';
    end

    if nargin < 3 || isempty(n)
        n = assumptions('refractive index'); 
    end

    if nargin < 2 || isempty(NA)
        NA = assumptions('numerical aperture'); 
    end 

    switch microscopeType 
        case 'conv'
            fwhm = 0.89 * (wl / (n - sqrt(n^2 - NA^2)));
        case 'conf'
            fwhm = 0.64 * (wl / (n - sqrt(n^2 - NA^2)));
        otherwise
            error('Unrecognized microscope type')
    end