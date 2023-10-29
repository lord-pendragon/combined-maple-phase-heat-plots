Pseudoplane := proc( inf::procedure, pa1::{`=`,`..`}, pa2::{`=`,`..`}, {logscale:=false, outside:="Black"} )
#option trace;
local f, g, p, ColorFunc, Ans, xmin, xmax, ymin, ymax, C;
    
    if type(pa1,`=`) then
        xmin, xmax := lhs(rhs(pa1)),rhs(rhs(pa1));
    else
        xmin, xmax := lhs(pa1),rhs(pa1)
    end if;
    
    if type(pa2,`=`) then
        ymin, ymax := lhs(rhs(pa2)),rhs(rhs(pa2));
    else
        ymin, ymax := lhs(pa2),rhs(pa2);
    end if;
    
    if ymin < 0 then
            WARNING("Negative y<0 not plotted") 
        end if;
    
    f := p -> evalf(inf(p));
    xmax := evalf( xmax );
    ymax := evalf( ymax );
    
    Ans := proc( x, y )
    option remember;
    local Z;
        Z := evalf( f( x+I*y ) );
        return evalf( Re(Z)/`2*Pi` );
    end proc:

    C := ColorTools[Color]("HSV",outside);

    ColorFunc||(H,S,V) := (
       ((x,y)-> `if`(Ans(x,y) > 1 or Ans(x,y) < 0, C[1], Ans(x,y) )),
       ((x,y)-> `if`(Ans(x,y) > 1 or Ans(x,y) < 0, C[2], 1)),
       ((x,y)-> `if`(Ans(x,y) > 1 or Ans(x,y) < 0, C[3], 1))
    );
    
    p := plot3d( 
        [(x,y)->x, (x,y)->y, (x,y)->1],
        xmin..xmax,
        max(0,ymin)..ymax,
        scaling=constrained,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        style=patchnogrid,
        `if`(logscale,axis[2]=[mode=log],NULL),
        _rest
    ):
    
    g := plottools[transform]((x,y,z)->[x,y],p);
    return plots[display]( g(p) ):
    
end proc: