clear all; close all; clc;

% Distance from magnet rings to center plane, optimize this for uniformity.
zRing2Center = 1.27; 

% Get the points describing the rings of rods
isSq = false; % Set to true for square cross-section rods, false for round
nEval = 50; % Number of points per dimension for eval planes
nRods = 1;  % Number of rods
rRod = 0.125; % radius of 1/4 inch rods
rIn = 1.0;  % One inch ring radius
rOut = 2.0;  % One inch long rods
[srcPts,srcW,znPlanePts,xnPlanePts] = oneRodRing(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

plotQ(srcPts,10,"quad pts on two rings of rods");

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
efields = evalEfields(srcPts, srcW, evalPts);

% Convert efield to units of Gauss
% efields = efields .* (-6559/0.0668);
% efields = polyval(p,efields);

%Plot Ex,Ey and Ez for the two planes.
zpInd = 1:nPts;
xpInd = nPts+1:2*nPts;
% Mostly interested in z field
% figure(1);
% mesh(reshape(efields(1,xpInd),nSide,nSide));
% axis tight;
% figure(2);
% mesh(reshape(efields(2,xpInd),nSide,nSide));
% axis tight;
figure(3);
subplot(211)
mesh(reshape(xnPlanePts(2,:),nSide,nSide),reshape(xnPlanePts(3,:),nSide,nSide),reshape(efields(3,xpInd),nSide,nSide));
xlabel('y'); ylabel('z');
axis square;
title('Ex in y-z plane through origin (normal to x)');
subplot(212)
imagesc(xnPlanePts(2,:),xnPlanePts(3,:),reshape(efields(3,xpInd),nSide,nSide));
xlabel('y'); ylabel('z');
axis square;
% figure(4);
% mesh(reshape(efields(1,zpInd),nSide,nSide));
% axis tight;
% figure(5);
% mesh(reshape(efields(2,zpInd),nSide,nSide));
figure(6);
subplot(211)
mesh(reshape(znPlanePts(1,zpInd),nSide,nSide),reshape(znPlanePts(2,zpInd),nSide,nSide),reshape(efields(3,zpInd),nSide,nSide));
xlabel('x'); ylabel('y');
axis square;
title('Ez in x-y plane through origin (normal to z)');
subplot(212)
imagesc(znPlanePts(1,zpInd),znPlanePts(2,zpInd),reshape(efields(3,zpInd),nSide,nSide));
xlabel('x'); ylabel('y');
axis square;
