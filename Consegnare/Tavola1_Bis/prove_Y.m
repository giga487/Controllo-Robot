
clc

d_q = sym('d_qref',[6,1],'real');
dd_q = sym('dd_qref',[6,1],'real');
q = sym('q',[6,1],'real');

m = sym('m',[1,7],'real');
L = sym('L',[1,7],'real');

syms pi_1 pi_2 pi_3 pi_4 pi_5 pi_6 

pi_1  = m(1);
pi_2  = m(2);
pi_3  = m(3);
pi_4  = m(4);
pi_5  = m(5);
pi_6  = m(6);
pi_7  = L(1);
pi_8  = L(2);
pi_9  = L(3);
pi_10  = L(4);
pi_11  = L(5);
pi_12  = L(6);

pi_vec = [pi_1 pi_2 pi_3 pi_4 pi_5 pi_6 pi_7 pi_8 pi_9 pi_10 pi_11 pi_12].';

% Regressor columns computation      
Y = sym('Y', [6,length(pi_vec)]);

%% 
param_sym = [L;m]';
     
[B,C,G] = Dinamica(param_sym, q, d_q);

B_ = vpa(B);
C_ = vpa(C);
G_ = vpa(G);

DIN_C = B_*dd_q + C_*d_q + G_;


%% 

syms a
regressor = a*zeros(size(DIN_C,1),2); % just to make Y symbolic

for i=1:size(DIN_C,1)
    [c t] = coeffs(DIN_C(i), m(5));
    
    if size(t,2)==2
        regressor(i,:) = c;
    else
        if t==1
            regressor(i,1) = 0;
            regressor(i,2) = c;
        else
            regressor(i,1) = c;
            regressor(i,2) = 0;
        end
    end
    size(DIN_C,1)
end


simplify(DIN_C - regressor*[ m(5),1]')


%% 
matlabFunction(Y,'File','Regressor_function','Vars',{q,d_q,dd_q,L(1),L(2),L(3),L(4),L(5),L(6),m(1),m(2),m(3),m(4),m(6)});


%% 
Y = Regressor_function(q,d_q,dd_q,L(1),L(2),L(3),L(4),L(5),L(6),m(1),m(2),m(3),m(4),m(6));

%% 
simplify(DIN_C(1) - Y(1,:)*[ m(5),1]')

