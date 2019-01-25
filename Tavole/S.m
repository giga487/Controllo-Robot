%SKEWMATRIX

function SKEW = S(G_CM)

    SKEW = [0,-G_CM(3),G_CM(2);
            G_CM(3),0,-G_CM(1);
            -G_CM(2),G_CM(1),0];
    
    
end