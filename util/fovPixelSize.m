function x = fovPixelSize(fovWidth, varargin)
    % FOVPIXELSIZE
    %
    % Input:
    %   fovWidth        field of view width (degrees)
    % Optional inputs:
    %   axialLength     in mm, default = 16.56 (from 838)
    %
    % Output:
    %   pixelSize       in microns

    ip = inputParser();
    ip.CaseSensitive = false;
    addParameter(ip, 'axialLength', 16.56, @isnumeric);
    parse(ip, varargin{:});
    axialLength = ip.Results.axialLength;

    % Get degrees per pixel
    degPerPixel = fovWidth / 496;
    % Convert to microns 
    micronsPerDegree = 291.2 * (axialLength / 24.2);
    x = micronsPerDegree * degPerPixel;

