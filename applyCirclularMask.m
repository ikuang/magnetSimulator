function efieldsImage = applyCirclularMask(efields,nEval,xyzpInd)
% produces circular mask for displaying rings and sets the area outside the
% rings to the min value inside rings

% make circular mask for rings
mask = createCircularMask([nEval,nEval],[(nEval+1)/2 (nEval+1)/2],nEval/2);

% reshape efield vector
if(size(efields,1) ~= 1) 
    efieldsImage = reshape(efields(3,xyzpInd),nEval,nEval);
else
    efieldsImage = reshape(efields,nEval,nEval);
end

% mask image
efieldsImage = efieldsImage .* mask;

% find minimum value inside ring
minImage = efieldsImage(nEval/2,nEval/2);
for i = 1:nEval
    for j = 1:nEval
        if efieldsImage(i,j) ~= 0 && efieldsImage(i,j) < minImage
            minImage = efieldsImage(i,j);
        end
    end
end

% mask image with min value
efieldsImage = efieldsImage .* mask;
for i = 1:nEval
    for j = 1:nEval
        if efieldsImage(i,j) == 0
            if efieldsImage(i,j) < minImage 
                efieldsImage(i,j) = minImage;
            end
        end
    end
end
end 