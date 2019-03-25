
% prova_regressore

syms a1 a2 a3 a5 a4 a_head x1 x2 x3 x4 x5 x_head ...
     l_head kr Ixx_b Iyy_b Izz_b...
     m_b1 m_b2 m_b3 m_b4 m_b5 m_b6

pi_1  = m1;
pi_2  = m2;
pi_3  = m3;
pi_4  = m4;
pi_5  = m5;
pi_6  = m_head;
pi_7  = L;
pi_8  = a1;
pi_9  = a2;
pi_10 = a3;
pi_11 = a4;
pi_12 = a4;
pi_13 = a_head;


pi_vec = [pi_1 pi_2 pi_3 pi_4 pi_5 pi_6].';

[c t] = coeffs(dynamic(1), pi_1)