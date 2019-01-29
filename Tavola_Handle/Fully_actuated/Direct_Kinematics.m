function p = Direct_Kinematics(x1,x2,x3,x4,x5,x6)

global A1 A2 A3 A4 A5 A6
p = zeros(6,3);
a2 = 0.1;
a3 = 0.1;
a4 = 0.1;
a5 = 0.1;
a6 = 0.1;

R_ruota = 0.02;
A1 = [Rz_rad(x1),[R_ruota*x1,R_ruota,0]';
      0,0,0,1];
A2 = matrixDH(a2,0,0,x2+pi/10);
A3 = matrixDH(a3,0,0,x3+8*pi/10);
A4 = matrixDH(a4,0,0,x4-pi/2);
A5 = matrixDH(a5,0,0,x5+pi/2);
A6 = matrixDH(a6,0,0,x6+pi/2);

p(1,1:3) = A1(1:3,4);
T = A1*A2;
p(2,1:3) = T(1:3,4);
T = T*A3;
p(3,1:3) = T(1:3,4);
T = T*A4;
p(4,1:3) = T(1:3,4);
T = T*A5;
p(5,1:3) = T(1:3,4);
T = T*A6;
p(6,1:3) = T(1:3,4);

end