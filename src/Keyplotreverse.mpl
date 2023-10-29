Keyplotreverse := proc( inf::procedure, pa1::{`=`,`..`}, pa2::{`=`,`..`} )
local f, g, p, ColorFunc, rngx, rngy, X, Y, Z, Ans, ired, igreen, iblue, yhi, ylo;
    
    f := (x,y) -> evalf(inf(x,y));
    
    if type(pa1,`=`) then
        rngx := rhs(pa1);
    else
        rngx := pa1;
    end if;
    
    if type(pa2,`=`) then
        rngy := rhs(pa2);
    else
        rngy := pa2;
    end if;
	
	yhi:= rhs(rngy);
	ylo:= lhs(rngy);
    
    
    (X,Y,Z) := (
      ((x,y)->x),
      ((x,y)->y),
      ((x,y)->(y))
    );
    
	ired := z -> piecewise(z <= 1/8, 1/2 + 4*z, 1/8 < z and z < 3/8, 1, 3/8 <= z and z <= 5/8, 5/2 - 4*z, 0);
	igreen := z -> piecewise(z <= 1/8, 0, 1/8 < z and z < 3/8, 4*z - 1/2, 3/8 <= z and z <= 5/8, 1, 5/8 <= z and z <= 7/8, 7/2 - 4*z, 0);
	iblue := z -> piecewise(z <= 3/8, 0, 3/8 < z and z <= 5/8, 4*z - 3/2, 5/8 < z and z <= 7/8, 1, 9/2 - 4*z);
	
	
	
    ColorFunc||(R,G,B) := (
       ((x,y)-> ired( (yhi - y)/(yhi - ylo) ) ),
       ((x,y)-> igreen( (yhi - y)/(yhi - ylo) ) ),
	   ((x,y)-> iblue( (yhi - y)/(yhi - ylo) ) )
    );
    
    p := plot3d( 
        [X,Y,Z],
        ylo..0.2*yhi,
        rngy,
        scaling=unconstrained,
        color= [ColorFunc||(R,G,B), colortype= RGB],
        style=surface,
        scaling=constrained,
        lightmodel=none,
		orientation=[-90,90,0],
		labels = [" ", " ", gamma], 
		axis[1] = [color = white], 
		axis[2] = [color = white], 
		tickmarks = [0, 0, 2],
        _rest
    );
    
    return p;
    
end proc: