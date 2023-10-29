Klein := proc( inf::procedure, {Conjugated::boolean:=true} )
#http://mathworld.wolfram.com/Pseudosphere.html
local f, Ans, g, p, ColorFunc;
    
    f := z -> evalf( inf(z) );
    
    Ans := proc( u, v )
    option remember;
    local X,Y,Z;
        
        #T(p)
        #(X,Y) := (T@Sph2Pln@Pol2Sph)(u,v);
        (X,Y) := (Sph2Pln@Pol2Sph)(u,v);  #in RR2 interior of disk
        
        #f(T(p)) or f(T'(p)')
        #Z := `if`(Conjugated, f(X-I*Y), f(X+I*Y) );
        if Conjugated then
            (X,Y) := (X,-Y);
        else
            (X,Y) := (X,Y);
        end if;

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
        
        ##Re(f(T(p)))
        #X := Re(Z);
        #Y := 0;
        
        ##T(Re(f(T(p))))
        #(X, Y) := T(X,Y);
        
        ##Conjugated
        #return arg(X+I*Y);
        
    end proc:
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> Ans(u,v)),
       ((u,v)-> 1) $ 2
    );
    
    p := plot3d(
       [SphX,SphY,SphZ],
       0..`2*Pi`,
       0..`1*Pi`,
       color= [ColorFunc||(H,S,V), colortype= HSV],
       lightmodel= none,
       style=surface,
       _rest
    );
    
    g := plottools[transform]((x,y,z)->[x,y],p);
    
    return plots[display]( g(p), axes=none ):
    
end proc: