function qpts = mapPts(pc,p1,p2,quadpts)
% Assumes p1 and p2 are displacements from pc, qpts are in global coord.
     qpts = [p1, p2]*quadpts + pc;
end