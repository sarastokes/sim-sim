function value = assumptions(key)
    % ASSUMPTIONS
    %   
    % Description:
    %   A single location for hard-coded values
    %
    % Syntax:
    %   value = assumptions(key)
    %
    % History:
    %   18Feb2021 - SSP
    % ---------------------------------------------------------------------

    switch lower(key)
        case {'refractive index', 'n'}
            % lens, Atchinson ch 16 in Handbook of Visual Optics
            value = 1.42;
        case {'numerical aperture', 'na'}
            % Midpoint of Gray 2008 range (0.229-0.238)
            value = 0.2335;
        case {'fov pixels'}
            % Field of view width in pixels
            value = 496;
        case {'wavelength', 'wl'}
            % Center frequency of tdTomato filter before PMT 
            value = 0.590;
        case {'rhodamine excitation'}
            value = 0.555;
        case {'rhodamine emission'}
            value = 0.580;
        case 'axial length'
            value = 16.56;  % OD for 838
    end