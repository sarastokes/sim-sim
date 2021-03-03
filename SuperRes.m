classdef SuperRes < System

    methods
        function obj = SuperRes(varargin)
            obj@System('B', varargin{:});
            obj.update();
        end
    end

    methods
        function update(obj)
            obj.lFWHM = lateralFWHM(obj.wl, obj.NA, 'conv') / 2;
            obj.aFWHM = axialFWHM(obj.wl, obj.NA, obj.n, 'conf');
            obj.minVoxel(1:2) = 0.5 * nyquistSampleDistance(...
                'conv', 'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
            [~, obj.minVoxel(3)] = nyquistSampleDistance(...
                'conf', 'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
        end
        
        function psf = getPSF2D(obj, x, y)
            % Scale to account for factor of 2 improvement in resolution
            psf = psf2d('conv', 2*x, 2*y,... 
                'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
        end

        function I = getPSF3D(obj, x, y, z)
            Ix = psf2d('conv', 2*x, 2*y,... 
                'wl', obj.wl, 'na', obj.NA, 'n', obj.n);

            Iz = axialIntensityDist(z, 'conf',...
                'wl', obj.wl, 'na', obj.NA, 'n', obj.n);
            
            % TODO: optimize
            I = zeros(numel(x), numel(y), numel(z));
            for i = 1:numel(z)
                I(:, :, i) = Iz(i) * Ix;
            end
            
            I = I / max(I(:));

        end
    end
end