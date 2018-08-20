close all;
%% two rings
% Distance from magnet rings to center plane, optimize this for uniformity.
zRing2Center = 1.24; 

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
% efields = efields .* (174.5/-0.038362618395502);
efields = efields .* (81.5/-0.030399030235143);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
figure(2);
subplot(221)
mesh(reshape(xnPlanePts(2,:),nSide,nSide),reshape(xnPlanePts(3,:),nSide,nSide),reshape(efields(3,xpInd),nSide,nSide));
xlabel('y'); ylabel('z');
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(223)
imagesc(xnPlanePts(2,:),xnPlanePts(3,:),reshape(efields(3,xpInd),nSide,nSide));
xlabel('y'); ylabel('z');
axis square;
subplot(222)
mesh(reshape(znPlanePts(1,zpInd),nSide,nSide),reshape(znPlanePts(2,zpInd),nSide,nSide),reshape(efields(3,zpInd),nSide,nSide));
xlabel('x'); ylabel('y');
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(224)
% imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),reshape(efields(3,zpInd),nSide,nSide));
imagesc(reshape(efields(3,zpInd),nSide,nSide));
xlabel('x'); ylabel('y');
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
% efields = efields .* (174.5/-0.038362618395502);
efields = efields .* (81.5/-0.030399030235143);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
figure(4);
subplot(221)
mesh(reshape(xnPlanePts(2,:),nSide,nSide),reshape(xnPlanePts(3,:),nSide,nSide),reshape(efields(3,xpInd),nSide,nSide));
xlabel('y'); ylabel('z');
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(223)
imagesc(xnPlanePts(2,:),xnPlanePts(3,:),reshape(efields(3,xpInd),nSide,nSide));
xlabel('y'); ylabel('z');
axis square;
subplot(222)
mesh(reshape(znPlanePts(1,zpInd),nSide,nSide),reshape(znPlanePts(2,zpInd),nSide,nSide),reshape(efields(3,zpInd),nSide,nSide));
xlabel('x'); ylabel('y');
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(224)
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),reshape(efields(3,zpInd),nSide,nSide));
xlabel('x'); ylabel('y');
axis square;
suptitle('FOUR rings');



