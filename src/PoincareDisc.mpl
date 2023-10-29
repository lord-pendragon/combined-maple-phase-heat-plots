PoincareDisc := proc( inf::procedure, {Conjugated:=true} )
local X, Y, Z, Ans, P, p, f, S, ColorFunc;
    
    f := z -> evalf( inf(z) );
    
    Ans := proc( u, v )
    option remember;
    local X,Y,Z;
        
        #T(p)
        (X,Y) := (T@Sph2Pln@Pol2Sph)(u,v);
        
        if Conjugated then
            (X,Y) := (X,-Y);
        else
            (X,Y) := (X,Y);
        end if;

        #f(T(p)) or f(T'(p)')
        #Z := `if`(Conjugated, f(X-I*Y), f(X+I*Y) );
        (X, Y) := T(X,Y);
        Z := f(X+I*Y);

        #Re(f(T(p)))
        X := Re(Z);
        Y := 0;
        
        #T(Re(f(T(p))))
        (X, Y) := T(X,Y);
        
        if Conjugated then
            Y := -Y;
        end if;

        return arg(X-I*Y);

        ###BELOW IS OLD
        ##f(T(p)) or f(T'(p))
        #Z := `if`(Conjugated, f(X-I*Y), f(X+I*Y) );
        
        ##Re(f(T(p)))
        #X := Re(Z);
        #Y := 0;
        
        ##T(Re(f(T(p))))
        #(X, Y) := T(X,Y);
        
        #return arg( X+I*Y )/`2*Pi`;
        
    end proc:
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> Ans(u,v)),
       ((u,v)-> 1) $ 2
    );
    
    P := plot3d(
        [SphX,SphY,SphZ],
        0..`1*Pi`,
        0.01...`1*Pi`,
        numpoints=2^10,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        _rest
        ):
    
    p := plottools[transform]( (x,y,z) -> [(T@Sph2Pln)(x,y,z)], P )(P):
    
    return plots[display]( p, scaling=constrained, style=surface, axes=none, _rest );
    
end proc: