clear all; close all; clc;
% Distance from magnet rings to center plane, optimize this for uniformity.
zRing2Center = 0.882; 

isSq = false; % Set to true for square cross-section rods, false for round
nEval = 50; % Number of points per dimension for eval planes
nRods = 16;  % Number of rods
rRod = 0.125; % radius of 1/4 inch rods
% rIn = 0.6725;  % One inch ring radius
rIn = 0.84;  % One inch ring radius
rOut = rIn + 2.0;  % One inch long rods

%% 
% Get the points describing the rings of rods
nRings = 6;
[srcPts,srcW,znPlanePts,xnPlanePts] = nRodRings(nRings,zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

% figTitle = ['quad pts on ' int2str(nRings) ' rings of rods'];
% plotQ(srcPts,1,figTitle);

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
nPlanes = 21;
zPlanes = linspace(-zRing2Center/4,zRing2Center/4,nPlanes);
zFields = zeros(nPlanes,nEval*nEval);
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
f1 = figure(1);
filename = 'zEField2.gif';
for i = 1:nPlanes
    znPlanePts(3,:) = zPlanes(i);
    evalPts = [znPlanePts,xnPlanePts];
    efields = evalEfields(srcPts, srcW, evalPts);
    zFields(i,:) = efields(3,zpInd);

    %Plot Ez
    efieldsImage = applyCirclularMask(zFields(i,:),nEval,zpInd);
%     subplot(121)
%     mesh(reshape(znPlanePts(1,zpInd),nSide,nSide),reshape(znPlanePts(2,zpInd),nSide,nSide),efieldsImage);
%     xlabel('x'); ylabel('y');
%     axis square;
%     title('Ez in x-y plane through origin (normal to z)');
%     subplot(122)
    imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),efieldsImage);
    xlabel('x'); ylabel('y');
    axis square;
    caxis([188 197])
    colorbar;
    figTitle = ['z position: ' num2str(zPlanes(i)) ' inches'];
    suptitle(figTitle);
    
	% Write to the GIF File
    frame = getframe(f1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end


    disp(i)
%     pause;
    
end

%% 
figure;
subplot(131)
efieldsImageNeg = applyCirclularMask(zFields(1,:),nEval,zpInd);
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),efieldsImageNeg);
xlabel('x'); ylabel('y');
axis square;
caxis([191 195])
colorbar;
figTitle = ['z position: ' num2str(zPlanes(1)) ' inches'];
title(figTitle);
subplot(132)
efieldsImageZero = applyCirclularMask(zFields(11,:),nEval,zpInd);
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),efieldsImageZero);
xlabel('x'); ylabel('y');
axis square;
caxis([191 195])
colorbar;
figTitle = ['z position: ' num2str(zPlanes(11)) ' inches'];
title(figTitle);
subplot(133)
efieldsImagePos = applyCirclularMask(zFields(21,:),nEval,zpInd);
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),efieldsImagePos);
xlabel('x'); ylabel('y');
axis square;
caxis([191 195])
colorbar;
figTitle = ['z position: ' num2str(zPlanes(21)) ' inches'];
title(figTitle);


figure;
subplot(121)
imagesc(efieldsImageNeg-efieldsImageZero)
axis square
colorbar
subplot(122)
imagesc(efieldsImagePos-efieldsImageZero)
axis square
colorbar