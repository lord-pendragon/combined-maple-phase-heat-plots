PoincarePlanarUltra := proc( inf::procedure, pa1::{`=`,`..`}, pa2::{`=`,`..`}, {Conjugated:=true} )
local f, g, p, ColorFunc, X, Y, Z, rngx, rngy, IK, TP, invTP, toplot, unitcircle, modulusmap, squaremap;
    
    f := p -> evalf(inf(p));
    
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
    
    (X,Y,Z) := (
      ((x,y)->x),
      ((x,y)->y),
      ((x,y)->1)
    );
    
	IK:=z -> 2*(z+I)/abs(z+I)^2 - I:
	
	if Conjugated then
		TP:= z -> conjugate(IK(z)):
		invTP:= z -> IK(conjugate(z)):
		else
		TP:= z -> IK(z):
		invTP:= z-> IK(z):
	end if:
	
	modulusmap:= z -> abs(z):
	squaremap:= z -> z^2:
	
	toplot:= z -> (I*(TP(modulusmap(f(invTP(z))))))^2 :	
	
	
    ColorFunc||(H,S,V) := (
       ((x,y)-> arg(toplot(x+I*y))/`2*Pi` ),
       ((x,y)-> 1) $ 2
    );
    
    p := plot3d( 
        [X,Y,Z],
        rngx,
        rngy,
        scaling=constrained,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        axes=none,
        style=patchnogrid,
        _rest
    ):
    
	unitcircle:=plottools[circle]([0,0],1,color=black):
    g := plottools[transform]((x,y,z)->[x,y],p);
    
    return plots[display]( g(p) , unitcircle):
    
end proc: