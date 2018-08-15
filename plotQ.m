function plotQ(qpts,figNum,titleTxt)
if ~exist('figNum','var') figNum = 1; end
figure(figNum);
plot3(qpts(1,:),qpts(2,:),qpts(3,:),'*-');
xlabel('x'); ylabel('y'); zlabel('z');
if exist('titleTxt','var') title(titleTxt);
end