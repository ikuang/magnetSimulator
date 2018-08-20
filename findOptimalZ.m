startVal = 1.25;
step = 0.01;
endVal = 1.35; 
z = [startVal:step:endVal];
maxE = zeros(size(z));
for i = 1:numel(z)
    eFields = eField(z(i));
    nPts = size(eFields,2)/2;
    nSide = round(sqrt(nPts));

%     maxE(i) = min(eFields(3,:));
    
    hFig = figure(1);
    set(hFig, 'Position', [0 500 1200 400])
    subplot(132)
    zpInd = 1:nPts;
    mesh(reshape(eFields(3,zpInd),nSide,nSide));
    axis square;
    title('Ez in x-y plane through origin','fontsize',15);
    subplot(133)
    imagesc(reshape(eFields(3,zpInd),nSide,nSide));
    axis square;
    title('Ez in x-y plane through origin','fontsize',15);
    pause(0.5)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [eFields,zRing2Center] = eField(zRing2Center)
    % Get the points describing the rings of rods
    isSq = false; % Set to true for square cross-section rods, false for round
    nEval = 50; % Number of points per dimension for eval planes
    nRods = 16;  % Number of rods
    rRod = 0.125; % radius of 1/4 inch rods
    rIn = 1.0;  % One inch ring radius
    rOut = 2.0;  % One inch long rods
    [srcPts,srcW,znPlanePts,xnPlanePts] = twoRodRings(zRing2Center, nEval,nRods,rRod,rIn,rOut,isSq);

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
end 