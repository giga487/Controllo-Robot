

h = h1(1);

Lg1_h1 = jacobian(h,x)*g1_feedbackLaw; % 0
Lg2_h1 = jacobian(h,x)*g2_feedbackLaw; % 0

Lf1_h1 = jacobian(h,x)*f_feedbackLaw;  % diverzo da zero

Lg1_Lf1_h1 = jacobian(Lf1_h1,x)*g1_feedbackLaw; % 1
Lg2_Lf1_h1 = jacobian(Lf1_h1,x)*g2_feedbackLaw; % 0
%il grado relativo è 2  
Lf2_h1 = jacobian(Lf1_h1,x)*f_feedbackLaw;

% il grado relativo è 2.

h = h2(1);

Lg1_h2 = jacobian(h,x)*g1_feedbackLaw; % 0
Lg2_h2 = jacobian(h,x)*g2_feedbackLaw; % 0

Lf1_h2 = jacobian(h,x)*f_feedbackLaw;  % diverzo da zero

Lg1_Lf1_h2 = jacobian(Lf1_h2,x)*g1_feedbackLaw; % 1
Lg2_Lf1_h2 = jacobian(Lf1_h2,x)*g2_feedbackLaw; % 0
%il grado relativo è 2

Lf2_h2 = jacobian(Lf1_h2,x)*f_feedbackLaw;

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