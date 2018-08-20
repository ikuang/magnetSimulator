zEField = reshape(efields(3,zpInd),nSide,nSide);
xInd = reshape(znPlanePts(1,zpInd),nSide,nSide);
yInd = reshape(znPlanePts(2,zpInd),nSide,nSide);

E = [zEField(50,25) zEField(47,25) zEField(45,25) zEField(40,25) zEField(30,25) zEField(25,25) zEField(15,25) zEField(1,25)];
eGauss = [6559 3481.7 2403 944 265.9  174.5 81.5 38.2];

figure 
plot(E,eGauss)

p = polyfit(E,eGauss,4);
estGauss = polyval(p,E);

% plot(E,estGauss,E,eGauss)
xlabel('calculated')
ylabel('K&J');