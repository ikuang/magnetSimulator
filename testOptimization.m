clear all; close all; clc;

options = optimoptions('fsolve','PlotFcn',@optimplotfirstorderopt,'Algorithm','levenberg-marquardt','Display','iter-detailed','OptimalityTolerance',1e-9);
fun = @eField;
z0 = 1;  
zRing2Center = fsolve(fun,z0,options)
print('-f10','../latex/figures/question3','-dpng')


function eFieldVar = eField(zRing2Center)
% Get the points describing the rings of rods
isSq = true; % Set to true for square cross-section rods, false for round
nEval = 50; % Number of points per dimension for eval planes
nRods = 16;  % Number of rods
rRod = 0.125; % radius of 1/4 inch rods
rIn = 1.0;  % One inch ring radius
rOut =2.0;  % One inch long rods
[srcPts,srcW,znPlanePts,xnPlanePts] = twoRodRings(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

hFig = figure(10);
set(hFig, 'Position', [0 500 1200 400])
subplot(131)
plot3(srcPts(1,:),srcPts(2,:),srcPts(3,:),'*-');
xlabel('x'); ylabel('y'); zlabel('z');
plotTitle = ['zRing2Center = ' num2str(zRing2Center)];
title(plotTitle,'fontsize',15);
grid on; axis square;

% Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
assert(size(xnPlanePts,2) == size(znPlanePts,2));
nPts = size(znPlanePts,2);
nSide = round(sqrt(nPts));
assert(nSide^2 == nPts);

% Evaluate the fields
evalPts = [znPlanePts,xnPlanePts];
eFields = evalEfields(srcPts, srcW, evalPts);
zpInd = 1:nPts;
eFields = reshape(eFields(3,zpInd),nSide,nSide);
% eFields = eFields .* (174.5/-0.038362618395502);
eFields = eFields .* (81.5/-0.030399030235143);


% Find 25x25 pixel area in center of Ez field
eCenter = eFields(round(nSide/4):floor(nSide*3/4),round(nSide/4):floor(nSide*3/4));
subplot(132)
imagesc(eFields);
colorbar;
axis square;
title('0.5x0.5 inch FOV inside rings','fontsize',15);
subplot(133)
imagesc(eCenter);
colorbar;
axis square;
title('Center 0.25x0.25 inch FOV','fontsize',15);
eCenter = reshape(eCenter,nSide/2*nSide/2,1);
eFieldVar = var(eCenter);
end 