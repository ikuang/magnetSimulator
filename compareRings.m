close all;
% Distance from magnet rings to center plane, optimize this for uniformity.
zRing2Center = 0.882; 

isSq = false; % Set to true for square cross-section rods, false for round
nEval = 50; % Number of points per dimension for eval planes
nRods = 16;  % Number of rods
rRod = 0.125; % radius of 1/4 inch rods
% rIn = 0.6725;  % One inch ring radius
rIn = 0.84;  % One inch ring radius
rOut = rIn + 2.0;  % One inch long rods

%% 1
% Get the points describing the rings of rods
nRings = 6;
[srcPts,srcW,znPlanePts,xnPlanePts] = nRodRings(nRings,zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

figTitle = ['quad pts on ' int2str(nRings) ' rings of rods'];
plotQ(srcPts,1,figTitle);

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
efields = evalEfields(srcPts, srcW, evalPts);

% Convert efield to units of Gauss
% efields = efields .* (81.5/-0.030399030235143);
% efields = efields .* (16.1/-0.022016312720158);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
figure(2);
subplot(221)
efieldsImage = applyCirclularMask(efields,nEval,xpInd);
mesh(reshape(xnPlanePts(2,:),nSide,nSide),reshape(xnPlanePts(3,:),nSide,nSide),efieldsImage);
xlabel('y'); ylabel('z');
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(223)
imagesc(xnPlanePts(2,:),xnPlanePts(3,:),efieldsImage);
xlabel('y'); ylabel('z');
axis square;
subplot(222)
efieldsImage = applyCirclularMask(efields,nEval,zpInd);
mesh(reshape(znPlanePts(1,zpInd),nSide,nSide),reshape(znPlanePts(2,zpInd),nSide,nSide),efieldsImage);
% caxis(cLim);
xlabel('x'); ylabel('y');
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(224)
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),efieldsImage);
xlabel('x'); ylabel('y');
axis square;
figTitle = [int2str(nRings) ' RINGS OF RODS'];
suptitle(figTitle);

%% 2
% Get the points describing the rings of rods (same parameters as for 2 rings)
nRings = 4;
[srcPts,srcW,znPlanePts,xnPlanePts] = nRodRings(nRings,zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

figTitle = ['quad pts on ' int2str(nRings) ' rings of rods'];
plotQ(srcPts,1,figTitle);

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
efields = evalEfields(srcPts, srcW, evalPts);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
figure(4);
subplot(221)
efieldsImage = applyCirclularMask(efields,nEval,xpInd);
mesh(reshape(xnPlanePts(2,:),nSide,nSide),reshape(xnPlanePts(3,:),nSide,nSide),efieldsImage);
xlabel('y'); ylabel('z');
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(223)
imagesc(xnPlanePts(2,:),xnPlanePts(3,:),efieldsImage);
xlabel('y'); ylabel('z');
axis square;
subplot(222)
efieldsImage = applyCirclularMask(efields,nEval,zpInd);
mesh(reshape(znPlanePts(1,zpInd),nSide,nSide),reshape(znPlanePts(2,zpInd),nSide,nSide),efieldsImage);
xlabel('x'); ylabel('y');
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(224)
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),efieldsImage);
xlabel('x'); ylabel('y');
axis square;
figTitle = [int2str(nRings) ' RINGS OF RODS'];
suptitle(figTitle);

