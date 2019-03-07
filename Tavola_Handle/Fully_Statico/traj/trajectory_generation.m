% Structure for storing every generated trajectory
% traject = struct(3);

qr_tot = vertcat(qr1,qr2,qr3,qr4);

for i = 1:4
 
% first cubic polynomial
qi1  = qr_tot(i,1);
dqi1 = qr_tot(i,2);
qf1  = qr_tot(i,3);
dqf1 = qr_tot(i,4);

% second cubic polynomial
qi2  = qf1;
dqi2 = dqf1;
qf2  = qr_tot(i,5);
dqf2 = qr_tot(i,6);

% third cubic polynomial
qi3  = qf2;
dqi3 = dqf2;
qf3  = qr_tot(i,7);
dqf3 = qr_tot(i,8);

tf  = qr_tot(i,9);

% T = .1;
% tf = tf3;

q_vec   = zeros(1,tf/T);
dq_vec  = zeros(1,tf/T);
ddq_vec = zeros(1,tf/T);

% t = 0;
j = 1;    
    
% First cubic polynomial    
    for t = 0:T:tf    
    
        [a0, a1, a2, a3] = pol_coeffs(qi1,dqi1,qf1,dqf1,tf);        

        q_vec(j)   = a3*t^3 + a2*t^2 + a1*t + a0;
        dq_vec(j)  = 3*a3*t^2 + 2*a2*t + a1;
        ddq_vec(j) = 6*a3*t + 2*a2;
    
        j = j+1;
    end

% Second cubic polynomial    
for t = 0:T:tf     
    
    [a0, a1, a2, a3] = pol_coeffs(qi2,dqi2,qf2,dqf2,tf);
        

    q_vec(j)   = a3*t^3 + a2*t^2 + a1*t + a0;
    dq_vec(j)  = 3*a3*t^2 + 2*a2*t + a1;
    ddq_vec(j) = 6*a3*t + 2*a2;
    
    
    j = j+1;
end

% Third cubic polynomial    
for t = 0:T:tf     
    
    [a0, a1, a2, a3] = pol_coeffs(qi3,dqi3,qf3,dqf3,tf);
        

    q_vec(j)   = a3*t^3 + a2*t^2 + a1*t + a0;
    dq_vec(j)  = 3*a3*t^2 + 2*a2*t + a1;
    ddq_vec(j) = 6*a3*t + 2*a2;
    
    
    j = j+1;
end

% Complete cubic polynomial trajectory for joint i
traject(i).q     = q_vec;
traject(i).dq    = dq_vec;
traject(i).ddq   = ddq_vec;

end