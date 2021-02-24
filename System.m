classdef System < handle

    properties (SetAccess = private)
        systemName
        wl 
        NA
        n 
    end

    properties (SetAccess = protected)
        lFWHM
        aFWHM
        minVoxel = [NaN, NaN, NaN]
    end

    properties (Dependent = true)
        lSD
        aSD
    end

    methods (Abstract)
        psf = getPSF2D(obj, x, y)
        psf = getPSF3D(obj, x, y, z)
    end

    methods 
        function obj = System(systemName, varargin)
            obj.systemName = systemName;
            [obj.wl, obj.NA, obj.n] = parseParameters(varargin{:});
        end

        function lSD = get.lSD(obj)
            lSD = fwhm2sd(obj.lFWHM);
        end

        function aSD = get.aSD(obj)
            aSD = fwhm2sd(obj.aFWHM);
        end
    end

    methods
        function update(obj)
            % Set by child functions
        end
    end
end 