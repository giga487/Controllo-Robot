
clc


dd_qref = sym('dd_qref',[6,1],'real');
d_qref = sym('d_qref',[6,1],'real');
q = sym('q',[6,1],'real');

Y = Y_matrix(dd_qref, d_qref, q, parameter);

DIN_P = Y*pi_vec;

[B,C,G] = Dinamica(parameter,q,dq);

DIN_C = B*dd_qref + C*d_qref + G;


RES = DIN_P - DIN_C


