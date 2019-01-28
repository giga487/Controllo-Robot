
function A2 = A2_3D(x1,x2,x3,L)
    

    Rsc = Rx_rad(x1)*Ry_rad(x2)*Rz_rad(x3);

    A2 = [Rsc, Rsc*[0,0,L]'; %CM DELL'ASTA
         0,0,0,1]; 
end