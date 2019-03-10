function G = gen_dinamica_G(q,parameter)

x1 = q(1);
x2 = q(2);
x3 = q(3);
x4 = q(4);
x5 = q(5);
m_r = parameter(1);
m_c = parameter(2);
R_r = parameter(3);
L = parameter(4);
a = parameter(5);


G = [ ((981*cos(x1)*cos(x3))/100 - (981*sin(x1)*sin(x2)*sin(x3))/100)*((a*m_c)/2 + (a*m_r)/2) + ((981*cos(x1)*sin(x3))/100 + (981*cos(x3)*sin(x1)*sin(x2))/100)*((a*m_c)/2 + (a*m_r)/2) - (981*cos(x2)*sin(x1)*(L*m_c + 2*L*m_r))/100;
                                                             (981*cos(x1)*cos(x2)*sin(x3)*((a*m_c)/2 + (a*m_r)/2))/100 - (981*cos(x1)*cos(x2)*cos(x3)*((a*m_c)/2 + (a*m_r)/2))/100 - (981*cos(x1)*sin(x2)*(L*m_c + 2*L*m_r))/100;
                                               ((981*cos(x3)*sin(x1))/100 + (981*cos(x1)*sin(x2)*sin(x3))/100)*((a*m_c)/2 + (a*m_r)/2) - ((981*sin(x1)*sin(x3))/100 - (981*cos(x1)*cos(x3)*sin(x2))/100)*((a*m_c)/2 + (a*m_r)/2);
                                                                                                                                                                                                                               0;
                                                                                                                                                                                                                               0];
 

end
