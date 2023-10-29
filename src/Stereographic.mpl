Stereographic := proc( inf::procedure )
local ColorFunc, plotargs, Ans, f;
    
    f := z -> evalf( inf(z) );
    
    Ans := proc( u, v )
    local X,Y,Z;
        
        (X,Y) := (Sph2Pln@Pol2Sph)(u,v);
        
        return evalf( arg( f( X+I*Y ) )/`2*Pi` );
        
    end proc:
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> Ans(u,v)),
       ((u,v)-> 1) $ 2
    );
    
    plotargs := _rest;
    
    return 
    plot3d(
        [SphX,SphY,SphZ], 
        0..`2*Pi`,
        0..`1*Pi`,
        numpoints=2^10,
        color= [ColorFunc||(H,S,V), colortype= HSV],
        scaling=constrained,
        axes=boxed,
        lightmodel=none,
        style=surface,
        plotargs );
        
end proc: