%% Maximum Intensity Projection with color coding for depth information
% written by 
% Job Bouwman
% 02-12-2014
% contact: jgbouwman@hotmail.com
% input 3D image, the intensity projection is taken along the 3rd dimension
function colorMIP(image_3D)
    %% crop for nice visualization: 
    msk = round(image_3D./(image_3D + eps));
    % The original indices in which the ROI is located: 
    x1 = find(squeeze(sum(sum(msk, 1),3))); 
    y1 = find(squeeze(sum(sum(msk, 2),3)));
    z1 = find(squeeze(sum(sum(msk, 1),2))); 
    % The size of the new matrix:
        NyxzNew = [length(y1),length(x1),length(z1)]+2;
    % The new indices in which the ROI will be located: 
        x2 = x1 + (-x1(1) + 1 + round((NyxzNew(2) - length(x1))/2));
        y2 = y1 + (-y1(1) + 1 + round((NyxzNew(1) - length(y1))/2)); 
        z2 = z1 + (-z1(1) + 1 + round((NyxzNew(3) - length(z1))/2));
    % Embedding the new matrix:
        image_3DNew = zeros(NyxzNew); 
        image_3DNew(y2,x2,z2) = image_3D(y1, x1, z1); 
        image_3D = image_3DNew; clear image_3DNew;
    
	% The '3d-ish' colorbar: 
    edge = 15;    
    image_3D = padarray(image_3D, [edge, edge, 0], 'post');
    N = size(image_3D);
    M = max(image_3D(:));
    for k = 1:edge
        ny = N(1) - edge + k;
        nx = N(2) - edge + k;
        image_3D(ny,1:(k+1), round(k/(edge+1)*N(3)))  = 1/0;
        image_3D(1:(k+1),nx, round(k/(edge+1)*N(3)))  = 1/0;
        if k < edge
            image_3D(ny,[k+1 ((k+ N(2)-edge))], :)  = 0;   
            image_3D([k+1 ((k+ N(1)-edge))],nx,:)  = 0;   
            image_3D(ny,(k+2):(k+ N(2)-(edge+1)) , round((k-0.5)/(edge)*N(3)))  = 2/3*M;
            image_3D((k+2):(k+ N(1)-(edge+1)) ,nx, round((k-0.5)/(edge)*N(3)))  = 1/3*M;
        else
             image_3D(ny,(k+1):(k+ N(2)-edge) , :)  = 0;
             image_3D((k+1):(k+N(1)-edge), nx, :)  = 0;
        end
    end
        
    
    % color coding along the z-axis (using complex numbers)
    [X,Y,Z] = meshgrid(1:N(2), 1:N(1), (-N(3)/2:N(3)/2-1)/N(3));
    Z = exp(-1i*(Z*1.75*pi));
    image_2D = flipud(max(image_3D.*Z, [], 3)); 
    % visual:
    figureFULL;
    vcc(image_2D); 
%     figureFULL;
%     subplot(1,2,1); vbw(abs(image_2D)); 
%     subplot(1,2,2); vcc(image_2D); 
end
    
function [] = vcc(complexData2D, varargin)
%      figureFULL;
    
    %% Aim: visualize 2D complex image in rgb
    
    % input: 
    % - complexData2D:  just what it says :-)
    % - string (optional) that determines the scaling: 
    %   no argument: linear intensity scaling
    %   's'        : root scaling
    %   'l'        : log scaling
    
    % magnitude displays the intensity
    % - black:        minimum intensity 
    % - full color:   maximum intensity
    
    % color diplays the phase 
    % - blue:   -pi
    % - green:  -pi/2
    % - yellow = 0;
    % - orange:  pi/2
    % - purple:  pi
    
    % One exception
    % - white: inf
 
    % jgbouwman@hotmail.com, 18 july 2014
    
    
    %% Scaling (default is linear)
    if isempty(varargin)
        scaling = 'linear';
    else
        scaling = varargin{1};
    end
    
    
    %% WHITE: 
    % All values that are infinite:
    whiteMask = double(uint8(isinf(complexData2D)));
    % ... initially set to zero:
    complexData2D(whiteMask==1) = 0;
    
    %% COLOR: 
    % settings for the color coding: 
    rgbPEAK  = [5/16, -3/16, -0.9]*pi; % at which phase each channel peaks
    rgbWIDTH = [1.4, 1, 0.4]; % a measure for the (relative) width of each peak 
    rgbMEAN  = [0.7, 0.7, 0.5]; % (MAX + MIN)/2 for each channel
    phase = angle(complexData2D);
    phaseColorMap = ones([size(complexData2D), 3]);
    
    rgbMAXminMIN = 2*(1 - rgbMEAN);
    rgbMINIMUM   = 2*(rgbMEAN - 0.5);
    for c = 1:3
        if rgbWIDTH(c) > 1
            pow  = rgbWIDTH(c);
            peak = pi + rgbPEAK(c);
            phaseColorMap(:,:,c) =  1 -rgbMAXminMIN(c)*(cos(angle(exp(1i*(phase-peak))))/2+0.5).^pow;
        else
            pow  = 1/rgbWIDTH(c);
            peak = rgbPEAK(c);
            phaseColorMap(:,:,c) =  rgbMINIMUM(c) + rgbMAXminMIN(c)*(cos(angle(exp(1i*(phase-peak))))/2+0.5).^pow;
        end
    end
      
    % INCLUDE WHITE IN COLORMAP:
    phaseColorMap = max(phaseColorMap, repmat(whiteMask, [1,1,3]));
    
    %% SET INTENSITY (determined by magnitude):
    switch scaling
        case 'linear'
            magnIntensityMap = abs(complexData2D);
            magnIntensityMap = magnIntensityMap./max(magnIntensityMap(:));
        case 's'         
            magnIntensityMap = sqrt(abs(complexData2D));
            magnIntensityMap = magnIntensityMap./max(magnIntensityMap(:));
%              magnIntensityMap = (magnIntensityMap - min(magnIntensityMap(:)))/(max(magnIntensityMap(:)) - min(magnIntensityMap(:)));
        case 'l'
%             A = abs(complexData2D);
%             minA = min(min(A(A>0)))
%             maxA = max(max(A(A>0)))
%             A(A==0) = minA.^2/maxA;
%             minA = min(min(A(A>0)))
%             
            magnIntensityMap = log(eps + abs(complexData2D));
%             scale to [0-1]
            magnIntensityMap = (magnIntensityMap - min(magnIntensityMap(:)))/(max(magnIntensityMap(:)) - min(magnIntensityMap(:)));
    end
    
    
    % INCLUDE WHITE IN INTENSITY MAP:
    magnIntensityMap = repmat(max(magnIntensityMap, whiteMask), [1,1,3]);
    
    
    %% SHOW IT:
    vcc_rgb = phaseColorMap.*magnIntensityMap;
    imagesc(vcc_rgb);
    
    axis equal tight;
    axis off
    set(gca,'xcolor','w','ycolor','w','xtick',[],'ytick',[])
    set(gcf,'color','w')
    set(gca,'box','on')
%     set(gca,'box','off')
    set(gca,'visible','off')
end
function [] = vbw(scalarData2D, varargin)
%  
    % jgbouwman@hotmail.com, 18 july 2014
    
    
    %% Scaling (default is linear)
    if isempty(varargin)
        scaling = 'linear';
        scalarData2D = scalarData2D;
    else
        scaling = varargin{1};
        
        if scaling == 's';
            scalarData2D = sqrt(scalarData2D);
        else
            scalarData2D = log(eps + abs(scalarData2D));
        end
    end
    
    %% SHOW IT:
    imagesc(scalarData2D); colormap gray; 
    
    axis equal tight;
    axis off
    set(gca,'xcolor','w','ycolor','w','xtick',[],'ytick',[])
    set(gcf,'color','w')
    set(gca,'box','on')
%     set(gca,'box','off')
    set(gca,'visible','off')
end
function figureFULL(varargin)
    if isempty(varargin)
        scrsz = get(0,'ScreenSize'); % full screen looks better
    else
        scrsz = varargin{1};
    end    
    figure('Position', scrsz, 'Units', 'normalized');
    axes('Position',[0 0 1 1], 'Units','normalized');
end