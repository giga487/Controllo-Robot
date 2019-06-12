
clc
clear
close all

% Inverted Pendulum 

syms Mb R Mw Iwa cz Iyy H D g Ka Ixx Izz G
x = sym('x', [7 1], 'real');
%x = x y  theta alpha d_alpha v d_theta  

g15 = Mb*(R^2) + 2*Mw*(R^2) + 2*Iwa + Mb*cos(x(4))*cz*R;
g16 = -R*(Mb*cos(x(4))*cz*R + Iyy + Mb*cz^2);

g1 = [0;0;0;0;g15;g16;0];
g2 = [0;0;0;0;0;0;1];

f1 = [x(6)*cos(x(3));
         x(6)*sin(x(3));
         x(7);
         x(5)];

f2(1,1) = sin(2*x(4))*((x(7))^2)*H/D + (1/2)*(Mb*cz*R*x(5))^2*sin(2*x(4))/D+(1/2)*(-(Mb*R)^2 *cz-4*Iwa*Mb*cz-4*Mb*Mw*cz*R^2)*g*sin(x(4))/D;
f2(2,1) = Ka*(x(7))^2 + (1/2)*g*sin(2*x(4))/D*(Mb*cz*R)^2 + (1/4)*(-4*Iyy*Mb*R^2*cz-4*R^2*Mb^2*cz^3)*sin(2*x(4))*x(5)^2/D;
f2(3,1) = (-(Ixx-Izz)*R^2-Mb*cz^2*R^2)*sin(2*x(4))*x(5)*x(7)/G - sin(x(4))*R^2*Mb*cz*x(6)*x(7)/G;

f = [f1;f2];
y = [x(3); x(4)];
h1 = y(1,1);
h2 = y(2,1);




%% Condizione 1 dell'esistenza di una soluzione.
% è possibile trovare un cambiamento di variabile e le funzioni di
% retroazione degli stati?

% adf6g1 = liebracket(f,g1,x,6); %span generico 
% adf6g2 = liebracket(f,g2,x,6);
% 
% rank([adf6g1,adf6g2])
%% condizione 2, la distribuzione è involutiva?



%% FeedBack Linearization

f_feedbackLaw = [f(1,1);
                 f(2,1);
                 f(3,1);
                 f(4,1);
                 0;
                 f2(2,1)-g16/g15*f2(1,1);
                 0];

g1_feedbackLaw = [0;0;0;0;0;0;1];
g2_feedbackLaw = [0;0;0;0;1;g16/g15;0];

adf2g = liebracket(f_feedbackLaw,g1_feedbackLaw,x,1);

%% grado relativo di ogni uscita
Lf1_h1 = jacobian(h1,x)*f;
Lf2_h1 = jacobian(Lf1_h1,x)*f;
Lf3_h1 = jacobian(Lf2_h1,x)*f;
% 
% Lg1_h1 = jacobian(h1,x)*g1_feedbackLaw;
% Lg1_Lf1_h1 = jacobian(Lf1_h1,x)*g1_feedbackLaw
% 
% Lg2_h1 = jacobian(h1,x)*g2_feedbackLaw;
% Lg2_Lf1_h1 = jacobian(Lf1_h1,x)*g2_feedbackLaw;
% Lg2_Lf2_h1 = jacobian(Lf2_h1,x)*g2_feedbackLaw;

%% Genero le 2 matrici
% il valore Lg1_h1 indica che l'uscita non entra nella derivata della
% uscita, quindi io posso andare in basso fino a che non ho almeno una
% Lg_n_h1 diverso da zero.

% h = h1(1);
% 
% Lg1_h1 = jacobian(h,x)*g1_feedbackLaw % 0
% Lg2_h1 = jacobian(h,x)*g2_feedbackLaw % 0
% 
% Lf1_h1 = jacobian(h,x)*f_feedbackLaw  % diverzo da zero
% 
% Lg1_Lf1_h1 = jacobian(Lf1_h1,x)*g1; % 1
% Lg2_Lf1_h1 = jacobian(Lf1_h1,x)*g2_feedbackLaw; % 0
% 
% Lf2_h1 = jacobian(Lf1_h1,x)*f_feedbackLaw
% 
% % il grado relativo è 2.
% 
% h = h2(1);
% 
% Lg1_h2 = jacobian(h,x)*g1_feedbackLaw; % 0
% Lg2_h2 = jacobian(h,x)*g2_feedbackLaw; % 0
% 
% Lf1_h2 = jacobian(h,x)*f_feedbackLaw  % diverzo da zero
% 
% Lg1_Lf1_h2 = jacobian(Lf1_h2,x)*g1_feedbackLaw; % 1
% Lg2_Lf1_h2 = jacobian(Lf1_h2,x)*g2_feedbackLaw; % 0
% 
% Lf2_h2 = jacobian(Lf1_h2,x)*f_feedbackLaw
% 
% Gamma = [Lf2_h1;Lf2_h2];
% E = [Lg1_Lf1_h1,Lg2_Lf1_h1;
%      Lg1_Lf1_h2,Lg2_Lf1_h2];
% 

h = h1(1);

Lg1_h1 = jacobian(h,x)*g1; % 0
Lg2_h1 = jacobian(h,x)*g2; % 0

Lf1_h1 = jacobian(h,x)*f  % diverzo da zero

Lg1_Lf1_h1 = jacobian(Lf1_h1,x)*g1; % 1
Lg2_Lf1_h1 = jacobian(Lf1_h1,x)*g2; % 0
%il grado relativo è 2
Lf2_h1 = jacobian(Lf1_h1,x)*f

% il grado relativo è 2.

h = h2(1);

Lg1_h2 = jacobian(h,x)*g1; % 0
Lg2_h2 = jacobian(h,x)*g2; % 0

Lf1_h2 = jacobian(h,x)*f;  % diverzo da zero

Lg1_Lf1_h2 = jacobian(Lf1_h2,x)*g1; % 1
Lg2_Lf1_h2 = jacobian(Lf1_h2,x)*g2; % 0
%il grado relativo è 2

Lf2_h2 = jacobian(Lf1_h2,x)*f;

Gamma = [Lf2_h1;Lf2_h2];
E = [Lg1_Lf1_h1,Lg2_Lf1_h1;
     Lg1_Lf1_h2,Lg2_Lf1_h2];


%se la matrice E è invertibile il sistema ha grado relativo vettoriale
% r = (2 2)' e grado relativo 4
% posso quindi riscrivere il mio sistema nel seguente modo:


Phi = [h1;
       Lf1_h1;
       h2;
       Lf1_h2];
       
%mi mancano 3 elementi per finire la feedback linearization




































