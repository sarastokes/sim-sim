classdef FloodIllum < System

    methods
        function obj = FloodIllum(varargin)
            obj@System('A', varargin{:});
            obj.update();
        end
    end

    methods
        function update(obj)
            obj.lFWHM = lateralFWHM(obj.wl, obj.NA, 'conv');
            obj.aFWHM = axialFWHM(obj.wl, obj.NA, obj.n, 'conv');
            [obj.minVoxel(1:2), obj.minVoxel(3)] = nyquistSampleDistance(...
                'conv', 'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
        end

        function psf = getPSF2D(obj, x, y)
            psf = psf2d('conv', x, y, 'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
        end

        function psf = getPSF3D(obj, x, y, z)
            psf = psf3d('conv', x, y, z,... 
                'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
        end
    end
end