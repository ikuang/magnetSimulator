function [qpts,w] = rod2pts(pfs,dpbs,dpss,dpts,quadpts,wquad)
% pf = rod center front, 
% dpb = rod center back - pf 
% dps = rod side - pf
% dpt = rod top - pf
% quadpts = 3xnquadpts matrix of pts
% wquad = nquadpts-long vector of weights

nRods = size(pfs,2);
nQuadPts = length(wquad);
assert(size(dpbs,2) == nRods);
assert(size(dpss,2) == nRods);
assert(size(dpts,2) == nRods);
assert(size(quadpts,2) == nQuadPts);

nTotalPts = 2*nRods*nQuadPts;
w = zeros(nTotalPts,1);
qpts = zeros(3,nTotalPts);

ptsIndex = 1;
for i = 1:nRods
    pf = pfs(:,i);
    dpb = dpbs(:,i);
    dps = dpss(:,i);
    dpt = dpts(:,i);
    area = 2*norm(dps)*norm(dpt);
    
    %Insure orthogonality of back point and side
    assert(abs(dpb'*dps) < 1.0e-10*(norm(dpb)*norm(dps)));
    assert(abs(dpb'*dpt) < 1.0e-10*(norm(dpb)*norm(dpt)));
    assert(abs(dpt'*dps) < 1.0e-10*(norm(dps)*norm(dpt)));
    
    qpts(:,ptsIndex:ptsIndex+nQuadPts-1) = mapPts(pf,dps,dpt,quadpts);
    w(ptsIndex:ptsIndex+nQuadPts-1) = area*wquad;
    ptsIndex = ptsIndex + nQuadPts;
    qpts(:,ptsIndex:ptsIndex+nQuadPts-1) = mapPts(pf+dpb,dps,dpt,quadpts);
    w(ptsIndex:ptsIndex+nQuadPts-1) = area*wquad;
    ptsIndex = ptsIndex + nQuadPts;
end
end

