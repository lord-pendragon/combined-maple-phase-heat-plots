PoincareUltraDynamic := proc( inf::procedure, {Conjugated:=true} )
local X, Y, Z, f, Ans, Height;
    
    f := z ->  evalf( inf(z) );

	Height := proc(u,v)
		local XX,YY,ZZ,output;
		if Conjugated then 
			(XX,YY):=T(u*cos(v),-u*sin(v));
		else 
			(XX,YY):=T(u*cos(v),u*sin(v));
		end if;
		ZZ:=f(XX+I*YY);
		ZZ:=Re(ZZ);
		(XX,YY):=T(ZZ,0);
		if Conjugated then
			ZZ:=XX-I*YY;
		else
			ZZ:=XX+I*YY;
		end if;
		output:= arg(ZZ);
		if Conjugated then
			if is(output>3*Pi/2) then
				output:=output-2*Pi;
			end if;
		else
			if is(output<Pi/2) then
				output:= output+2*Pi;
			end if;
		end if;
	output;	
	end proc;
    
    (X,Y,Z) := (
      ((u,v)-> u*cos(v)),
      ((u,v)-> u*sin(v)),
      ((u,v)-> Height(u,v))
    );
    
    Ans := proc( u, v )
    option remember;
    local X,Y,Z;
        
        #T(p)
        (X,Y) := (u*cos(v),u*sin(v));
        
        if Conjugated then
            (X,Y) := (X,-Y);
        else
            (X,Y) := (X,Y);
        end if;
        
        #f(T(p)) or f(T'(p))
		(X,Y):=T(X,Y);
        Z := f(X+I*Y);
        
        #abs(f(T(p)))
        X := abs(Z);
        Y := 0;
        
        #T(abs(f(T(p))))
        (X, Y) := T(X,Y);
        
        return evalf( 2*arg( I*X-Y ) );
        
    end proc:
    
    ColorFunc||(H,S,V) := (
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, 0, Ans(u,v)/`2*Pi`)),
       ((u,v)-> `if`(`2*Pi` < Ans(u,v) or Ans(u,v) < 0, 0, 1))$2
    );
    
    return plot3d(
       [X,Y,Z],
       0..1,
       0..2*Pi,
       color= [ColorFunc||(H,S,V), colortype=HSV],
       lightmodel= none,
       _rest
    );
    
end proc: