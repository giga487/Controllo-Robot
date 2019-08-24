clc
clear
close all
digits(3)

sym param

m = sym('m',[1,7],'real');
L = sym('L',[1,7],'real');

pi = sym('pi',[6,1],'real');
d_q = sym('d_q',[6,1],'real');
dd_q = sym('dd_q',[6,1],'real');
q = sym('q',[6,1],'real');

param = [L(1),L(2),L(3),L(4),L(5),L(6),0;
         m(1),m(2),m(3),m(4),m(5),m(6),m(7)];

parameter = param';

[B,C,G] = Dinamica(parameter,q,d_q);

% B = vpa(B);
% C = vpa(C);
% G = vpa(G);

dyn = B*dd_q + C*d_q + G;
%%

pi = m(1:6)';
% syms pi_1 pi_2 pi_3 pi_4 pi_5 pi_6 pi_7 pi_8 pi_9 pi_10 pi_11 pi_12

% pi_1  = m(1);
% pi_2  = m(2);
% pi_3  = m(3);
% pi_4  = m(4);
% pi_5  = m(5);
% pi_6  = m(6);
% pi_7  = L(1);
% pi_8  = L(2);
% pi_9  = L(3);
% pi_10  = L(4);
% pi_11  = L(5);
% pi_12  = L(6);

% pi_vec = [pi_1 pi_2 pi_3 pi_4 pi_5 pi_6];% pi_7 pi_8 pi_9 pi_10 pi_11 pi_12].';

% Regressor columns computation      
Y = sym('Y', [6,length(pi)]);

%% 

for i = 1:6
    
    %---------------------------------------------------------------------   
    % take every term with coefficients formed by m1, r1 (see t1)
    [c1,t1] = coeffs(dyn(i), pi(1));
    C1 = arrayfun(@char,t1,'Un',0);
    % take only term with coefficients formed by m1, r1 and characters
    % * ('\w*\*\w*'), thus selecting only terms with m1*r1^2
    % (see regexp(C1,'\w*\*\w*','match'))
    C1 = c1(~cellfun('isempty',regexp(C1,'\w*m_b\w*','match')));
    
    if isempty(C1)
        C1 = 0;
    end 

    Y(i,1) = c1(1);
    
    %% 
    [c2,t2] = coeffs(dyn(i), pi(2));
    C2 = arrayfun(@char,t2,'Un',0);
    C2 = c2(~cellfun('isempty',regexp(C2,'\w*m_c\w*','match')));

    if isempty(C2)
        C2 = 0;
    end
    Y(i,2) = c2(1);
    
    %% 
    [c3,t3] = coeffs(dyn(i), pi(3));
    C3 = arrayfun(@char,t3,'Un',0);
    C3 = c3(~cellfun('isempty',regexp(C3,'\w*mfb_rm\w*','match')));
    
    if isempty(C3)
        C3 = 0;
    end
    Y(i,3) = c3(1);
    
    %% 
    [c4,t4] = coeffs(dyn(i), pi(4));
    C4 = arrayfun(@char,t4,'Un',0);
    C4 = c4(~cellfun('isempty',regexp(C4,'\w*m_n\w*','match')));

    if isempty(C4)
        C4 = 0;
    end
    Y(i,4) = c4(1);
    %%
    [c5,t5] = coeffs(dyn(i), pi(5));
    C5 = arrayfun(@char,t5,'Un',0);
    C5 = c5(~cellfun('isempty',regexp(C5,'\w*\^\w*m_p\w*','match')));

    if isempty(C5)
        C5 = 0;
    end
    Y(i,5) = c5(1);

    %%
    
    [c6,t6] = coeffs(dyn(i), pi(6));
    C6 = arrayfun(@char,t6,'Un',0);
    C6 = c6(~cellfun('isempty',regexp(C6,'\w*F\w*','match')));

    if isempty(C6)
        C6 = 0;
    end
    
    Y(i,6) = c6(1);
end

Y = vpa(Y);
dyn = vpa(dyn);
%% 
simplify(dyn - Y)

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

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);
    
d_q1 = d_q(1);
d_q2 = d_q(2);
d_q3 = d_q(3);
d_q4 = d_q(4);
d_q5 = d_q(5);
d_q6 = d_q(6);

dd_q1 = dd_q(1);
dd_q2 = dd_q(2);
dd_q3 = dd_q(3);
dd_q4 = dd_q(4);
dd_q5 = dd_q(5);
dd_q6 = dd_q(6);

m1 = parameter(1,2);
m2 = parameter(2,2);
m3 = parameter(3,2);
m4 = parameter(4,2);
m5 = parameter(5,2);
m6 = parameter(6,2)

L1 = parameter(1,1);
L2 = parameter(2,1);
L3 = parameter(3,1);
L4 = parameter(4,1);
L5 = parameter(5,1);
L6 = parameter(6,1);

Y = Regressor_function(q(1),q(2),q(3),q(4),q(5),q(6),d_q(1),d_q(2),d_q(3),d_q(4),d_q(5),d_q(6),dd_q(1),dd_q(2),dd_q(3),dd_q(4),dd_q(5),dd_q(6),m1,m2,m3,m4,m5,m6,L1,L2,L3,L4,L5,L6)


%% 

simplify(dyn-Y)

