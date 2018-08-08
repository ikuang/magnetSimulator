function rods = rodZRing(zIn,rIn,rOut,rRod,nRods)
% Creates rod data structure with nRods forming the spokes of a wheel
% in the x-y plane about x=0,y=0,z=zIn with inside radius rIn and outside
% radius rOut.

oneNrod = ones(1,nRods);
ths = [0:nRods-1]*(2*pi/nRods);
rpfs = [rIn*cos(ths);rIn*sin(ths);zIn*oneNrod];
rdpbs = [rOut*cos(ths);rOut*sin(ths);zIn*oneNrod]-rpfs;
rdpts = [0,0,rRod]'*oneNrod; % Top in Z direction
rdpss = cross(rdpbs,rdpts,1);
rdpss = rdpss*diag(rRod./sqrt(sum(rdpss.^2,1)));

rods.rpfs = rpfs;
rods.rdpbs = rdpbs;
rods.rdpts = rdpts;
rods.rdpss = rdpss;

end


