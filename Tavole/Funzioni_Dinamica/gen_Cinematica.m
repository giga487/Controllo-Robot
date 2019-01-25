function T(1:3,4) =  gen_Cinematica(q,parameter)  

x1 = q(1);
x2 = q(2);
x3 = q(3);

L = parameter(4);

R = Rx_rad(x1)*Ry_rad(x2)*Rz_rad(x3);

T = [R, R*[0,0,L]';
     0,0,0,1];
end