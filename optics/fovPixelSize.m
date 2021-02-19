function x = fovPixelSize(fovWidth, varargin)
    % FOVPIXELSIZE
    %
    % Description:
    %   Get field of view pixel size in microns
    %
    % Syntax:
    %   x = fovPixelSize(fovWidth, varargin)
    %
    % Input:
    %   fovWidth        field of view width (degrees)
    % Optional key-value inputs:
    %   axialLength     in mm, default = 16.56 (from 838)
    %
    % Output:
    %   pixelSize       in microns
    %
    % History:
    %   18Feb2021 - SSP
    % ---------------------------------------------------------------------

    ip = inputParser();
    ip.CaseSensitive = false;
    addParameter(ip, 'axialLength', 16.56, @isnumeric);
    parse(ip, varargin{:});
    axialLength = ip.Results.axialLength;

    % Get degrees per pixel
    degPerPixel = fovWidth / assumptions('fov pixels');
    % Convert to microns 
    micronsPerDegree = 291.2 * (axialLength / 24.2);
    x = micronsPerDegree * degPerPixel;
