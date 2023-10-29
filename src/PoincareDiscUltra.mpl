PoincareDiscUltra := proc( inf::procedure, {Conjugated::boolean:=true} )
#PoincareDiscUltra
#From book
local X, Y, Z, Ans, plotargs, P, p, f, S, ColorFunc;
    
    f := z -> evalf( inf(z) );
    
    Ans := proc( u, v )
    option remember;
    local X,Y,Z;
        
        #T(p)
        (X,Y) := (Sph2Pln@Pol2Sph)(u,v);

#REMOVE CONJUGATION OPTION
        if Conjugated then
            (X,Y) := (X,-Y);
        else
            (X,Y) := (X,Y);
        end if;
        
        #f(T(p)) or f(T'(p))
        Z := f(X+I*Y);
        
        #abs(f(T(p)))
        X := abs(Z);
        Y := 0;
        
        #T(abs(f(T(p))))
        (X, Y) := T(X,Y);
        
        return evalf( arg( I*X-Y ) );
        
    end proc:
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> Ans(u,v)),
       ((u,v)-> 1) $ 2
    );
    
    plotargs := _rest;
    
    P := plot3d(
        [SphX,SphY,SphZ],
        0..`1*Pi`,
        0.01...`1*Pi`,
        numpoints=2^10,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        plotargs
        ):
    
    p := plottools[transform]( (x,y,z) -> [(T@Sph2Pln)(x,y,z)], P )(P):
    
    return plots[display]( p, scaling=constrained, style=surface, axes=none, plotargs );
    
end proc: