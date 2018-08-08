function eFields = evalEfields(srcPts, srcW, evalPts)
nSrc = size(srcPts,2);
nEval = size(evalPts,2);

srcXYZ = ones(2,nSrc);
evalXYZ = -ones(2,nEval);
mats2e = cell(3);
eFields = zeros(3,nEval);
Rcubed = zeros(nSrc,nEval);

% Form x-x', y-y' and z-z' annd (dx^2+dy^2+dz^2)^1.5
for i = 1:3
    srcXYZ(1,:) = srcPts(i,:);
    evalXYZ(2,:) = evalPts(i,:);
    mats2e{i} = srcXYZ' * evalXYZ;
    Rcubed = Rcubed + mats2e{i}.^2;
end
Rcubed = Rcubed.*sqrt(Rcubed);

for i = 1:3
    eFields(i,:) = srcW'*(mats2e{i}./Rcubed);
end
end