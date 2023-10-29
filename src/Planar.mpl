Planar := proc( inf::procedure, pa1::{`=`,`..`}, pa2::{`=`,`..`} )
local f, g, p, ColorFunc, X, Y, Z, rngx, rngy;
    
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
    
    ColorFunc||(H,S,V) := (
       ((x,y)-> arg(f(x+I*y))/`2*Pi` ),
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
    
    g := plottools[transform]((x,y,z)->[x,y],p);
    plots[display]( g(p) ):
    
    return g(p);
    
end proc: