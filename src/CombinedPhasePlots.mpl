visualizeFunction := proc(
    visualTypes,
    f,
    L := -3, R := 3, T := 3, B := -3, 
    gridside := 500, 
    useAngleLines := false, anglemarks := 10,
    useSaturation := false, satmarks := 10, 
    useRings := false
)
    local NumericEventHandler, A, C, ing, arglines, saturation, n, m, x, y, image, ARG;
    NumericEventHandler := (proc(operator, operands, defVal) return 0; end proc);
    
    local showPhasePortrait := false ;
    local showFlatPortrait := false ;
    local showReimannSphere := false ;

    local SphX, SphY, SphZ, Pol2Sph, Sph2Pln, Ans, u, v; # For Reimann Sphere
    
    SphX := (u, v) -> sqrt(1 - cos(v)^2)*cos(u);
    SphY := (u, v) -> sqrt(1 - cos(v)^2)*sin(u);
    SphZ := (u, v) -> cos(v);
    Pol2Sph := (u, v) -> (SphX(u, v), SphY(u, v), SphZ(u, v));
    Sph2Pln := proc(x, y, z) return x/(1 - z), y/(1 - z); end proc;
    Ans := proc(u, v) local X, Y, Z; X, Y := (Sph2Pln@Pol2Sph)(u, v); return evalf(f(X + Y*I)); end proc;
    

    if visualType = 1 then 
        showPhasePortrait := true;
        print("PhasePortrait Selected");
    else 
        if visualType = 2 then 
            showFlatPortrait := true;
            print("FlatPortrait Selected");
        else 
            if visualType = 3 then 
                showReimannSphere := true;
                print("ReimannSphere Selected");
            else 
                return print("Invalid Visual Type entered, please choose from 1 to 3 and whether or not you want angle lines");
            end if;
        end if;
    end if;
    A := Array(0 .. gridside, 0 .. gridside, 'datatype' = 'float[8]', 'order' = 'C_order');
    C := Array(0 .. gridside, 0 .. gridside, 1 .. 3, 'datatype' = 'float[8]', 'order' = 'C_order');

    ing := z -> piecewise(z <= 1, z, log(z + exp(1) - 1));

    if useAngleLines then
        print("AngleLines Enabled");
        arglines := t -> piecewise(0.50 <= ceil(anglemarks*t) - anglemarks*t, 1, 1 + (-1)*0.45*(ceil(anglemarks*t) - anglemarks*t)/0.5);
    end if;

    if useSaturation then
        print("Saturation Enabled");
        saturation := t -> 1 + (-1)*0.6*(ceil(satmarks*t) - satmarks*t)^10;
    end if;

    if showReimannSphere then
        Ans(1, 1);
        A := Array(0 .. gridside, 0 .. gridside, 1 .. 3, 'datatype' = 'float[8]', 'order' = 'C_order');
        C := Array(0 .. gridside, 0 .. gridside, 1 .. 3, 'datatype' = 'float[8]', 'order' = 'C_order');
        Zeta(0, 1);
        NumericEventHandler(division_by_zero = (proc(operator, operands, defVal) if operator = Zeta then return 0; else return defVal; end if; end proc));
        Zeta(0, 1);

        for n from 0 to gridside do
            u := 2*n*Pi/gridside;
            for m to gridside do
                v := m*Pi/gridside;
                image := evalf(Ans(u, v));
                A[n, m, 1] := evalf(SphX(u, v));
                A[n, m, 2] := evalf(SphY(u, v));
                A[n, m, 3] := evalf(SphZ(u, v));
                if Im(image) < 0 then
                    ARG := 2*Pi + argument(image);
                else
                    ARG := argument(image);
                end if;
                C[n, m, 1] := evalf(ARG/(2*Pi));
                C[n, m, 2] := evalf(1);
                C[n, m, 3] := evalf(1 - 0.25*(ing(abs(image)) - floor(ing(abs(image)))) - 0.25*(ceil(anglemarks*ARG/(2*Pi)) - anglemarks*ARG/(2*Pi)));
            end do;
        end do;

        return PLOT3D(MESH(A), COLOR(HSV, C), ORIENTATION(70, -18, -158), LIGHTMODEL(NONE));

    else
        if showPhasePortrait then
            for n from 0 to gridside do
                x := n*(R - L)/gridside + L;
                for m from 0 to gridside do
                    y := m*(T - B)/gridside + B;
                    image := evalf(f(x + y*I));
                    A[n, m] := evalf(abs(image));
                    if Im(image) < 0 then
                        ARG := 2*Pi + argument(image);
                    else
                        ARG := argument(image);
                    end if;
                    C[n, m, 1] := evalf(ARG/(2*Pi));
                    if useSaturation then
                        C[n, m, 2] := saturation(ARG/(2*Pi));
                    else
                        C[n, m, 2] := 1;
                    end if;
                    if useAngleLines then
                        C[n, m, 3] := evalf(1 - 0.25*(ing(abs(image)) - floor(ing(abs(image)))) - 0.25*(ceil(anglemarks*ARG/(2*Pi)) - anglemarks*ARG/(2*Pi)));
                    else
                        C[n, m, 3] := evalf(1 - 0.6*(ing(abs(image)) - floor(ing(abs(image)))));
                    end if;
                end do;
            end do;
        else
            if showFlatPortrait then
                for n from 0 to gridside do
                    for m from 0 to gridside do A[n, m] := -1; 
                        image := evalf(f(x + y*I));
                        A[n, m] := evalf(abs(image));
                        if Im(image) < 0 then
                            ARG := 2*Pi + argument(image);
                        else
                            ARG := argument(image);
                        end if;
                        C[n, m, 1] := evalf(ARG/(2*Pi));
                        if useSaturation then
                            C[n, m, 2] := saturation(ARG/(2*Pi));
                        else
                            C[n, m, 2] := 1;
                        end if;
                        if useAngleLines then
                            C[n, m, 3] := evalf(1 - 0.6*(ing(abs(image)) - floor(ing(abs(image)))));
                        else
                            C[n, m, 3] := evalf(1 - 0.25*(ing(abs(image)) - floor(ing(abs(image)))) - 0.25*(ceil(anglemarks*ARG/(2*Pi)) - anglemarks*ARG/(2*Pi)));
                        end if;
                    end do;
                end do
            end if;
        end if;

        if useRings then
            print("Adding Rings");
            local center := 0;
            local r1 := 1;
            local r2 := 2;
            local linewidth := 1/100*(R - L);
            for n from 0 to gridside do
                x := n*(R - L)/gridside + L;
                for m from 0 to gridside do
                    y := m*(T - B)/gridside + B;
                    if r1 - linewidth <= evalf(abs(x + y*I - center)) and evalf(abs(x + y*I - center)) <= r1 + linewidth or r2 - linewidth <= evalf(abs(x + y*I - center)) and evalf(abs(x + y*I - center)) <= r2 + linewidth then
                        C[n, m, 1] := 0;
                        C[n, m, 2] := 0;
                        C[n, m, 3] := 0;
                    end if;
                end do;
            end do;
        end if;
        if showFlatPortrait then
            return PLOT3D(GRID(L .. R, B .. T, A), COLOR(HSV, C), LIGHTMODEL(NONE), ORIENTATION(-90, 0, 0), STYLE(PATCHNOGRID));
        else
            if showPhasePortrait then 
                return PLOT3D(GRID(L .. R, B .. T, A), COLOR(HSV, C));
            end if;
        end if;
    end if;
        
end proc;
