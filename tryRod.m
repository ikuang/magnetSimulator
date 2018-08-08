function [quadPtsTotal,wTotal,planePts] = twoRodRings(z)
[quadpts,wq] = integShape(false);
%{
rpc = [1,1,1]';
rdpb = [-2,-2,-2]';
rdpb = rdpb*2/norm((rdpb));
rdps = [-0.5,-0.5, 1]';
rdps = rdps*0.25/norm(rdps);
% create top point with same length as dps.
rdpt = cross(rdps,rdpb);
rdpt = rdpt*norm(rdps)/norm(rdpt);
rpc = [rpc, [1, 0, 0]'];
rdpb = [rdpb, [-2,0,0]'];
rdps = [rdps, [0,0.125,0]'];
rdpt = [rdpt, [0,0,0.125]'];
%}

%z = 1;
rods = rodZRing(z,1,3,0.125,16);
[qpts,w] = rod2pts(rods.rpfs,rods.rdpbs,rods.rdpss,rods.rdpts,quadpts,wq);
rods = rodZRing(-z,1,3,0.125,16);
[qpts2,w2] = rod2pts(rods.rpfs,rods.rdpbs,rods.rdpss,rods.rdpts,quadpts,wq);
quadPtsTotal = [qpts,qpts2];
wTotal = [w; w2];
nEval = 100;
oneEval = ones(1,nEval);
planePts = zeros(3,nEval*nEval);
xs = linspace(-z,z,100);

end



