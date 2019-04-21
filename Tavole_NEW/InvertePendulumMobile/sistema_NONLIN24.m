clc
clear 

syms g Mw m r l Jw Jtheta Jdelta D Tw Tv alfa Q P Beta real

% P = m*l^2 +Jtheta;
% Q = 2*Mw + 2*Jw/r^2 + m;
% alfa = D^2*(2*Mw + 2*Jw/r^2) + Jdelta;
% Beta = P*Q-(m*l*cos(x(3)))^2;

x = sym('x', [6 1], 'real'); % state

f = [ x(4);
      x(5);
      x(6);
      -m*(l^2)*sin(2*x(3))*x(6)*x(4)/(alfa+m*(l^2)*sin(x(3)));
     1/(2*Beta)*(-(m^2)*g*(l^2)*sin(2*x(3))-(m^2)*(l^3)*sin(2*x(3))*cos(x(3))*(x(4))^2+2*P*m*l*sin(x(3))*(x(6))^2);
     1/(2*Beta)*(-(m^2)*(l^2)*sin(2*x(3))*(x(6))^2+Q*m*(l^2)*sin(2*x(3))*(x(4))^2+2*Q*m*g*l*sin(x(3)))];

f = vpa(f,2); 

g1 = [0;
      0;
      0;
      D/(r*(alfa+m*(l^2)*(sin(x(3))^2)));
      0;
      0];
 
g2 = [0;
      0;
      0;
      0;
      (P + m*l*r*cos(x(3)))/(Beta*r);
      -(Q*r + m*l*cos(x(3)))/(Beta*r)];
  
F_sys = simplify(vpa(f,2));
G_sys = simplify(vpa([g1,g2],2));

