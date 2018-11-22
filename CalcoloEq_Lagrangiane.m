%% Cubli

%postura del cubo XYZ
syms theta1 theta2 theta3

Rsc = Rx_rad(theta1)*Ry_rad(theta2)*Rz_rad(theta3)

zero = zeros(3,1);

gsc = [Rsc   , zero;
       zero',    1];

