# Save this as a Maple Library (MPL) file
visualizeFunction := proc(
    L, R, T, B, gridside, f,
    useAngleLines, anglemarks,
    useSaturation, satmarks
)
    local NumericEventHandler, A, C, ing, arglines, saturation, n, m, x, y, image, ARG;
    NumericEventHandler := (proc(operator, operands, defVal) return 0; end proc);
    
    A := Array(0 .. gridside, 0 .. gridside, 'datatype' = 'float[8]', 'order' = 'C_order');
    C := Array(0 .. gridside, 0 .. gridside, 1 .. 3, 'datatype' = 'float[8]', 'order' = 'C_order');

    ing := z -> piecewise(z <= 1, z, log(z + exp(1) - 1));

    if useAngleLines then
        arglines := t -> piecewise(0.50 <= ceil(anglemarks*t) - anglemarks*t, 1, 1 + (-1)*0.45*(ceil(anglemarks*t) - anglemarks*t)/0.5);
    end if;

    if useSaturation then
        saturation := t -> 1 + (-1)*0.6*(ceil(satmarks*t) - satmarks*t)^10;
    end if;

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
                C[n, m, 3] := evalf(1 - 0.6*(ing(abs(image)) - floor(ing(abs(image)))));
            else
                C[n, m, 3] := evalf(1 - 0.25*(ing(abs(image)) - floor(ing(abs(image)))) - 0.25*(ceil(anglemarks*ARG/(2*Pi)) - anglemarks*ARG/(2*Pi)));
            end if;
        end do;
    end do;

    return PLOT3D(GRID(L .. R, B .. T, A), COLOR(HSV, C));
end proc;
