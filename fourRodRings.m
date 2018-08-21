function [quadPtsTotal,wTotal,znPlanePts,xnPlanePts] = fourRodRings(z,nEval,nRods,rRod,rIn,rOut,isSq,plotFrac)
% Create two rings, one at +z, one at -z
% Creates rod data structure with nRods forming the spokes of a wheel
% in the x-y plane about x=0,y=0,z=zIn with inside radius rIn and outside
% radius rOut.

% Polyfudge reduction for poly boundary length compared to circle.
polyFudge = 0.95;

% Set defaults
if ~exist('rRod','var') 
    rRod = 0.125; 
end
if ~exist('rIn','var') 
    rIn = 1.0; end
if ~exist('rOut','var') 
    rOut = 3.0; 
end
if ~exist('nRods','var') 
    nRods = floor(polyFudge*(rIn*pi)/rRod); 
end
if ~exist('plotFrac','var') 
    plotFrac = 0.5; 
end
if ~exist('isSq','var') 
    isSq = false; 
end
    
% Ad-Hoc way to make sure rod ends are not overlapping
assert(rRod*nRods <= polyFudge*pi*rIn);

% Rod end quadrature for the shape.
[quadpts,wq] = integShape(isSq);

%Create rod ring with at +z
rods = rodZRing(z,rIn,rOut,rRod,nRods);
[qpts,w] = rod2pts(rods.rpfs,rods.rdpbs,rods.rdpss,rods.rdpts,quadpts,wq);
rods = rodZRing(z+2*rRod,rIn,rOut,rRod,nRods,true);
[qpts1,w1] = rod2pts(rods.rpfs,rods.rdpbs,rods.rdpss,rods.rdpts,quadpts,wq);

%Create rod ring with at -z
rods = rodZRing(-z,rIn,rOut,rRod,nRods);
[qpts2,w2] = rod2pts(rods.rpfs,rods.rdpbs,rods.rdpss,rods.rdpts,quadpts,wq);
rods = rodZRing(-z-2*rRod,rIn,rOut,rRod,nRods,true);
[qpts3,w3] = rod2pts(rods.rpfs,rods.rdpbs,rods.rdpss,rods.rdpts,quadpts,wq);

% Merge quad pts and weights, note neg w for -z ring, magnets flipped.
quadPtsTotal = [qpts,qpts1,qpts2,qpts3];
wTotal = [w;w1;-w2;-w3];

% Create evaluation points for an x-y plane at z=0, and y-z plane at x = 0.
oneEval = ones(1,nEval);
znPlanePts = zeros(3,nEval*nEval);
xnPlanePts = znPlanePts;

% Evaluation points cover a plotFrac fraction of ring inner radius
xs = linspace(-rIn*plotFrac,rIn*plotFrac,nEval);
znPlanePts(1,:) = kron(oneEval,xs);
znPlanePts(2,:) = kron(xs,oneEval);
xnPlanePts(2,:) = kron(oneEval,xs);
xnPlanePts(3,:) = kron(xs,oneEval);

end



