function sd = fwhm2sd(fwhm)
    % FWHM2SD
    %
    % Description:
    %   Convert FWHM to standard deviation

    sd = fwhm / (2 * sqrt(2 * log(2)));