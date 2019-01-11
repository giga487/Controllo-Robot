function [B,C,G] = Generatore_Dinamica_SIMULINK(parameter,q1,q2,dq1,dq2)

g = 9.81;
L = parameter(1);
m_1 = parameter(2);
m_2 = parameter(3);
m_3 = parameter(4);
diametro_ruota = parameter(5);

x1 = q1; %Angolo di rotazione asta
x2 = q2; %Angolo di rotazione rotore
dx1 = dq1;
dx2 = dq2;

Izz2 = m_2*(diametro_ruota/2)^2; %RUOTA
Izz3 = L^2*m_3;      %MOTORE
Izz1 = m_1*(L^2)/12; %ASTA

B = [ Izz1 + Izz2 + Izz3 + (L^2*m_1)/4 + L^2*m_2 + L^2*m_3, Izz2;
                                                      Izz2, Izz2];
                                                  
C = [ 0, 0;
      0, 0];

G =  [-(L*g*sin(x1)*(m_1 + 2*m_2 + 2*m_3))/2;
                                           0];

end