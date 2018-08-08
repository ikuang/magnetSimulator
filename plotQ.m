function plotQ(qpts,figNum,titleTxt)
if ~exist('figNum','var') figNum = 1; end
figure(figNum);
plot3(qpts(1,:),qpts(2,:),qpts(3,:),'*-');
if exist('titleTxt','var') title(titleTxt);
end