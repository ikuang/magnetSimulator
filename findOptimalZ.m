startVal = 1.20;
step = 0.01;
endVal = 1.25; 
z = [startVal:step:endVal];
maxE = zeros(size(z));
for i = 1:numel(z)
    eFields = eField(z(i));
    nPts = size(eFields,2)/2;
    nSide = round(sqrt(nPts));

    maxE(i) = min(eFields(3,:));
    
    figure(1);
    zpInd = 1:nPts;
    mesh(reshape(eFields(3,zpInd),nSide,nSide));
    axis square;
    plotTitle = ['Ez in x-y plane through origin, zRing2Center = ' num2str(z(i))];
    title(plotTitle,'fontsize',15);
    pause(0.5)
end

% Plot max eField and corresponding z's
% figure(2);
% plot(z,maxE)

%Plot Ex,Ey and Ez for the two planes.
% figure(1);
% zpInd = 1:nPts;
% xpInd = nPts+1:2*nPts;
% subplot(221)
% mesh(reshape(eFields(3,xpInd),nSide,nSide));
% axis square;
% title('Ex in y-z plane through origin (normal to x)');
% subplot(223)
% imagesc(reshape(eFields(3,xpInd),nSide,nSide));
% axis square;
% subplot(222)
% mesh(reshape(eFields(3,zpInd),nSide,nSide));
% axis square;
% title('Ez in x-y plane through origin (normal to z)');
% subplot(224)
% imagesc(reshape(eFields(3,zpInd),nSide,nSide));
% axis square;

function [eFields,zRing2Center] = eField(zRing2Center)
    % Get the points describing the rings of rods
    isSq = false; % Set to true for square cross-section rods, false for round
    nEval = 50; % Number of points per dimension for eval planes
    nRods = 16;  % Number of rods
    rRod = 0.125; % radius of 1/4 inch rods
    rIn = 1.0;  % One inch ring radius
    rOut = 2.0;  % One inch long rods
    [srcPts,srcW,znPlanePts,xnPlanePts] = fourRodRings(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

%     plotQ(srcPts,10,"quad pts on two rings of rods");

    % Make sure the eval points in the x-y (zNormal) and y-z (xNormal) planes are equal-size squares
    assert(size(xnPlanePts,2) == size(znPlanePts,2));
    nPts = size(znPlanePts,2);
    nSide = round(sqrt(nPts));
    assert(nSide^2 == nPts);

    % Evaluate the fields
    evalPts = [znPlanePts,xnPlanePts];
    eFields = evalEfields(srcPts, srcW, evalPts);
end 