function a = halfApertureAngle(NA, n)
    % HALFAPERTUREANGLE
    %
    % Description:
    %   Half-aperture angle from numerical aperture and refractive index
    %
    % Syntax:
    %   a = halfApertureAngle(NA, n)
    %
    % Inputs:
    %   NA      numerical aperture
    %   n       index of refraction
    %
    % History:
    %   18Feb2020 - SSP
    % ---------------------------------------------------------------------

    a = asin(NA / n);
