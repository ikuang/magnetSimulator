close all;
%% two rings
% Distance from magnet rings to center plane, optimize this for uniformity.
zRing2Center = 1.25; 

% Get the points describing the rings of rods
isSq = false; % Set to true for square cross-section rods, false for round
nEval = 50; % Number of points per dimension for eval planes
nRods = 16;  % Number of rods
rRod = 0.125; % radius of 1/4 inch rods
rIn = 1.0;  % One inch ring radius
rOut = 2.0;  % One inch long rods
[srcPts,srcW,znPlanePts,xnPlanePts] = twoRodRings(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

plotQ(srcPts,1,"quad pts on TWO rings of rods");

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
efields = evalEfields(srcPts, srcW, evalPts);

% Convert efield to units of Gauss
efields = efields .* (-6559/0.0668);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
figure(2);
subplot(221)
mesh(reshape(efields(3,xpInd),nSide,nSide));
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(223)
imagesc(reshape(efields(3,xpInd),nSide,nSide));
axis square;
subplot(222)
mesh(reshape(efields(3,zpInd),nSide,nSide));
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(224)
imagesc(reshape(efields(3,zpInd),nSide,nSide));
axis square;
suptitle('TWO rings');


%% four rings
% Get the points describing the rings of rods (same parameters as for 2 rings)
[srcPts,srcW,znPlanePts,xnPlanePts] = fourRodRings(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

plotQ(srcPts,3,"quad pts on FOUR rings of rods");

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
efields = evalEfields(srcPts, srcW, evalPts);

% Convert efield to units of Gauss
efields = efields .* (-6559/0.0668);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
figure(4);
subplot(221)
mesh(reshape(efields(3,xpInd),nSide,nSide));
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(223)
imagesc(reshape(efields(3,xpInd),nSide,nSide));
axis square;
subplot(222)
mesh(reshape(efields(3,zpInd),nSide,nSide));
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(224)
imagesc(reshape(efields(3,zpInd),nSide,nSide));
axis square;
suptitle('FOUR rings');



