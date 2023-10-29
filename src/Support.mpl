`1*Pi` := evalf( Pi );
`2*Pi` := evalf( 2*Pi );
`Pi/2` := evalf( Pi/2 );

Sph2Pln := proc(x,y,z)
#Cartesean unit sphere to cartesean plane:  RR^3 -> RR^2
    return (x/(1-z), y/(1-z));
end proc;

S2P := Sph2Pln;

#Polar point to cartesean unit sphere:  RR x [0,2pi] -> RR^3.
#i.e. this is the parameterization of the unit sphere.
(SphX,SphY,SphZ) := (
  ((u,v)-> sqrt(1-cos(v)^2)*cos(u) ),
  ((u,v)-> sqrt(1-cos(v)^2)*sin(u) ),
  ((u,v)-> cos(v) )
);
#Polar to spherical
Pol2Sph := (u,v) -> (SphX,SphY,SphZ)(u,v);

#Upper half plane in cartesean to interior of unit disc.
T := (X,Y) -> ( 
  2*X/(X^2+Y^2+2*Y+1), 
  1-2/(X^2+Y^2+2*Y+1)*Y-2/(X^2+Y^2+2*Y+1) 
  );

arg := proc( Z::complex )
local ans;
    
    ans := evalf( argument( Z ) );
    
    if ans < 0 then
        ans := ans + `2*Pi`;
    end if;
    
    return ans;
    
end proc;
