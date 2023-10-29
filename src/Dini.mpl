Dini := proc( inf::procedure, inumax::{float,integer,rational}, {wraps::{float,integer,rational}:=2, twist::{float,integer,rational}:=.5},{outside:="Black"} )
#option trace;
#http://mathworld.wolfram.com/DinisSurface.html
local X, Y, Z, f, Ans, umax, C;
    
    f := z ->  evalf( inf(z) );
    
    (X,Y,Z) := (
      ((u,v)-> sech(u)*cos(v)),
      ((u,v)-> sech(u)*sin(v)),
      ((u,v)-> u - tanh(u)-twist*v)
    );
    
    #solve umax-tanh(umax) = inuxmax for umax
    umax := evalf( RootOf(exp(_Z)^2*_Z-exp(_Z)^2*inumax-exp(_Z)^2+_Z-inumax+1) );
    
    Ans:= proc(u,v)
    option remember; 
        evalf(Re(f(v+I*exp(u))));
    end proc;
	
	C := ColorTools[Color]("HSV",outside);
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, C[1], Ans(u,v)/`2*Pi`)),
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, C[2], 1)),
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, C[3], 1))
    );
	
    
    return plot3d(
       [X,Y,Z],
       0..umax,
       0..wraps*2*Pi,
       color= [ColorFunc||(H,S,V), colortype=HSV],
       lightmodel=none,
       _rest
    );
    
end proc: