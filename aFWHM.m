function fwhm = aFWHM(wl, NA, n, microscopeType)
    % AFWHM
    %
    % Description:
    %   Theoretical axial resolution 
    %
    % Syntax:
    %   fwhm = aFWHM(wl, n, NA, microscopeType)
    %
    % Inputs:
    %   wl                  float
    %       Wavelength
    %   NA                  float
    %       Numerical aperture (default = Gray 2008, 0.2335)
    %   n                   float
    %       Refractive index (default = lens, 1.44)
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
    % ---------------------------------------------------------------------

    if nargin < 4
        microscopeType = 'conv';
    end

    if nargin < 3 || isempty(n)
        % Refractive index of the lens
        n = 1.42;  
    end

    if nargin < 2 || isempty(NA)
        % Midpoint of Gray 2008 range
        NA = 0.229 + (0.238-0.229)/2;  
    end 

    switch microscopeType 
        case 'conv'
            fwhm = 0.89 * (wl / (n - sqrt(n^2 - NA^2)));
        case 'conf'
            fwhm = 0.64 * (wl / (n - sqrt(n^2 - NA^2)));
        otherwise
            error('Unrecognized microscope type')
    end