Pseudosphere := proc( inf::procedure, inumax::{float,integer,rational} )
#http://mathworld.wolfram.com/Pseudosphere.html
local X, Y, Z, f, Ans, umax;
    
    f := z ->  evalf( inf(z) );
    
    (X,Y,Z) := (
      ((u,v)-> sech(u)*cos(v)),
      ((u,v)-> sech(u)*sin(v)),
      ((u,v)-> u - tanh(u))
    );
    
    #solve umax-tanh(umax) = inuxmax for umax
    umax := evalf( RootOf(exp(_Z)^2*_Z-exp(_Z)^2*inumax-exp(_Z)^2+_Z-inumax+1) );
    
    Ans:= proc(u,v)
    option remember; 
        evalf(Re(f(v+I*exp(u))));
    end proc;
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, 0, Ans(u,v)/`2*Pi`)),
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, 0, 1))$2
    );
    
    return plot3d(
       [X,Y,Z],
       0..umax,
       0..`2*Pi`,
       color= [ColorFunc||(H,S,V), colortype=HSV],
       lightmodel= none,
       _rest
    );
    
end proc: