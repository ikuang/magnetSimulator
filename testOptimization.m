clear all; close all; clc;

% Distance from magnet rings to center plane, optimize this for uniformity.
% zRing2Center = 1.27; 

% Convert efield to units of Gauss
% efields = eField(zRing2Center) * -6549/0.065;



function eFieldMax = eField(zRing2Center)
% Get the points describing the rings of rods
isSq = false; % Set to true for square cross-section rods, false for round
nEval = 50; % Number of points per dimension for eval planes
nRods = 23;  % Number of rods
rRod = 0.125; % radius of 1/4 inch rods
rIn = 1.0;  % One inch ring radius
rOut = 2.0;  % One inch long rods
[srcPts,srcW,znPlanePts,xnPlanePts] = twoRodRings(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

plotQ(srcPts,10,"quad pts on two rings of rods");

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
eFields = evalEfields(srcPts, srcW, evalPts);
eFieldMax = max(eFields);
end 