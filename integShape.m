function  [quadpts,wq,EerrMax,E,Eerr,Em] = integShape(isSq,x,y,z)

if nargin < 4
    x = 1;
    y = 1;
    z = 1;
end

    function [fx,fy,fz] = Ef(r,th)
        if isSq  %Interpret r,th as x and y.
            xd = x - r;
            yd = y - th;
        else
            xd = x - r.*cos(th);
            yd = y - r.*sin(th);
        end
        R3 = (xd.^2+yd.^2+z.^2).^1.5;
        % Returned function for area dr*do
        fx = (xd./R3);
        fy = (yd./R3);
        fz = (z./R3);
    end

    function E = Efx(r,th)
        E = Ef(r,th);
    end
    function E = Efy(r,th)
        [~,E] = Ef(r,th);
    end
    function E = Efz(r,th)
        [~,~,E] = Ef(r,th);
    end

    function E = Efmx(r,th)
        rs = isSq + (1-isSq)*r;
        E = rs.*Efx(r,th);
    end
    function E = Efmy(r,th)
        rs = isSq + (1-isSq)*r;
        E = rs.*Efy(r,th);
    end
    function E = Efmz(r,th)
        rs = isSq + (1-isSq)*r;
        E = rs.*Efz(r,th);
    end


if isSq
    Em = [integral2(@Efmx,-1,1,-1,1),integral2(@Efmy,-1,1,-1,1),integral2(@Efmz,-1,1,-1,1)];
else
    Em = [integral2(@Efmx,0,1,0,2*pi),integral2(@Efmy,0,1,0,2*pi),integral2(@Efmz,0,1,0,2*pi)];
end

if isSq  
    [xg, wg] = gauss_legendre_rule_compute(4);
    w = wg'*wg;
    w = w(:)';
    vt = ones(length(xg),1);
    r = kron(xg',vt);
    theta = kron(vt,xg');
    quadpts = [r'; theta'];
else
    [wpr,rs,ths] = disk01_rule (2,8);
    vt = ones(length(ths),1);
    vr = ones(length(rs),1);
    w = kron(wpr,vt)'*pi;
    r = kron(rs,vt);
    theta = kron(vr,ths);
    quadpts = [(r.*cos(theta))'; (r.*sin(theta))'];
end
    
E = w*[Efx(r,theta),Efy(r,theta),Efz(r,theta)];
Eerr = (E-Em)/norm(Em);
EerrMax = max(abs(Eerr));
wq = w';

end



