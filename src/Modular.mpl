Modular := proc( inf::procedure, pa1::{`=`,`..`}, pa2::{`=`,`..`} )
local f, g, p, ColorFunc, rngx, rngy, X, Y, Z, Ans;
    
    f := z -> evalf(inf(z));
    
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
      ((x,y)->abs(f(x+I*y)))
    );
    
    ColorFunc||(H,S,V) := (
       ((x,y)-> arg( f(x+I*y) ) /`2*Pi` ),
       ((x,y)-> 1) $ 2
    );
    
    p := plot3d( 
        [X,Y,Z],
        rngx,
        rngy,
        scaling=unconstrained,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        style=surface,
        scaling=constrained,
        lightmodel=none,
        _rest
    );
    
    return p;
    
end proc: