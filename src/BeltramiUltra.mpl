BeltramiUltra := proc( inf::procedure, {Conjugated::boolean:=false} )
local CF, Ans, X, Y, Z, f, p, P;
    
    f := z -> evalf( inf(z) );
    
    Ans := proc( u, v )
    option remember;
    local X,Y,Z;
        
        #T(p)
        #(X,Y) := (T@Sph2Pln@Pol2Sph)(u,v);
        (X,Y) := (Sph2Pln@Pol2Sph)(u,v);  #in RR2 interior of disk
        
        #(X,Y) := `if`(Conjugated, (X,-Y), (X,Y) );
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
        X := abs(Z);
        Y := 0;
        
        #T(Re(f(T(p))))
        (X, Y) := T(X,Y);
        
        if Conjugated then
            Y := -Y;
        end if;

        Z := -I*X-Y;

        return arg(Z);
        
    end proc:
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> Ans(u,v)),
       ((u,v)-> 1) $ 2
    );
    
    
    P := plot3d(
        [SphX,SphY,SphZ],
        0..`2*Pi`,
        -evalf(Pi/2)..0,
        numpoints=2^10,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        scaling=constrained,
        lightmodel=none,
        style=surface,
        _rest );
    
    return P;
    
end proc: