function [a0, a1, a2, a3] = pol_coeffs(qi,dqi,qf,dqf,tf)

a0 = qi;
a1 = dqi;
a3 = dqf/tf^2 - 2*(qf - a0 - a1*tf)/tf^3 - a1/tf^2;
a2 = (qf - a0 -a1*tf -a3*tf^3)/tf^2;