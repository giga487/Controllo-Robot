clc
clear
close all

syms param h g real

%% 
% m = sym('m',[1,7],'real');
% L = sym('L',[1,7],'real');

syms m1 m2 m3 m4 m5 m6 h L1 L2 L3 L4 L5 L6 L7 real

pi = sym('pi',[6,1],'real');
d_q = sym('d_q',[6,1],'real');
dd_q = sym('dd_q',[6,1],'real');
q = sym('q',[6,1],'real');

% param = [L(1),L(2),L(3),L(4),L(5),L(6),L(7);
%          m(1),m(2),m(3),m(4),m(5),m(6),h];
param = [L1, L2, L3, L4, L5, L6, L7;
         m1, m2, m3, m4, m5, m6, h];

parameter = param';
Y = sym('Y', [6,length(pi)]);
%% 
[B,C,G] = dinamica_2(parameter,q,d_q,g);

% B = vpa(B);
% C = vpa(C);
% G = vpa(G);

dyn = B*dd_q + C*d_q + G;

pi = m5;

%% Regressor columns computation      

regressor = Y*zeros(6,2); % just to make Y symbolic

for i=1:size(Y,1)
    [c t] = coeffs(dyn(i), m5);
    
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
    
end

regressor = simplify(regressor);

% test to vefiry that B.ddq + C.dq + G + Fv.dq = Y.pi

%%
test = simplify(dyn-regressor*[m5;1]);

if any(test~=0)
    error('error in regressor computation')
end

%% 

fprintf('\nStarted creating Regressor function\n');
tic
matlabFunction(Y,'File','Regressor_function','Vars',[q, d_q, dd_q, pi', parameter(1:6,1)]);
toc 
fprintf('\nEnded Regressor function creation\n');

clear C1 C2 C3 C4 C5 C6 
clear c1 c2 c3 c4 c5 c6 
clear t1 t2 t3 t4 t5 t6

%%

syms g real

Y = Y_fnu(q,d_q,dd_q,parameter,g);

simplify(Y*[m5;1]-dyn)
