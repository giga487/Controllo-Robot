function I = Inertia_f(m,L)

    h = 0.1;

    Ixx_b = m*(h^2)/12;
    Iyy_b = m*(L^2)/12;
    Izz_b = m*(h^2+L^2)/12;


    I = [Ixx_b,0,0;
                0,Iyy_b,0;
                0,0,Izz_b;];
end