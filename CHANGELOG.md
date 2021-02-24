# CHANGELOG

### 02-22-2021
- New class-based approach to each imaging system (`System.m`, `FloodIllum.m`, `SuperRes.m`)
- `psf3d.m` - 3D PSF calculation
- `equalSpanAxes.m` - equalize X and Y dimensions of 2D neuron projection
- `getFrameVoxels.m` - returns size in microns of each pixel returned from the `getframe` function

### 02-21-2021
- `psf2d.m` - generates 2D PSF from `lateralIntensityDist.m`
- Changed `aFWHM.m` to `axialFWHM.m` and `lFWHM.m` to `lateralFWHM.m` for clarity and consistency

### 02-20-2021
- Added confocal option to `lateralIntensityDist.m` and `axialIntensityDist.m`
- `leica.m` - properties of Leica confocal used for some sample images
- Cleaned up inputs and outputs to `getSimResolutions.m`

### 02-19-2021
- `lateralIntensityDist.m`, `axialIntensityDist.m` - airy patterns for axial and lateral
- `lateralOU.m`, `axialOU.m` - convert to optical units 
- `parseParameters.m` - parameter parsing common to optical functions

### 02-18-2021
- `fovPixelSize.m` - get pixel size in microns for a specific field of view
- `nyquistSampleDist.m` - calculate critical Nyquist sampling distance
- `assumptions.m` - store hard-coded default values in a single place

### 02-10-2021
- `getSimResolutions.m` - utility function to compare the two systems

### 02-09-2021
- `main.m` - Script running resolution simulations (work in progress)
- `maxProj.m` - Fast plot of max Z-projection
- `viewMesh3.m` - Quick 3D rendering of a volume
- `voxelRange.m` - Returns voxel location vectors rather than bounding box alone

### 02-08-2021
- `getNeuronBounds.m` - get bounding box for neuron mesh
- `voxelBox.m` - adjust bounding box to divide evenly by voxel size
- Added `voxelise` package from Matlab File Exchange

### 02-07-2021
- `aFWHM.m`, `lFWHM.m` - theoretical axial and lateral resolution calculations from Wilson (2011)
- `fwhm2sd.m` - convert FWHM to standard deviation
- Initialized repository