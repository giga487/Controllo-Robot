
% Jacobian Calc
% Trasformazione Geometria
A1 = [Rz_rad(x1),[R_ruota*x1,R_ruota,0]';
      0,0,0,1];
A2 = matrixDH(a2,0,0,x2);
A3 = matrixDH(a3,0,0,x3+sym(8*pi/10));
A4 = matrixDH(a4,0,0,x4-sym(pi/2));
A5 = matrixDH(a5,0,0,x5+sym(pi/2));
A6 = matrixDH(a6,0,0,x6+sym(pi/2));

%% Solo il carrello
p = A1(1:3,4);
R = A1(1:3,1:3);

%Jacobian Ruota
Jp_ruota = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                     jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                     jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);

dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);
TOR6vee = simplify(R'*dR_x6);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

Jo_ruota =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];
               
J_ruota = [Jp_ruota;Jo_ruota];

%% Jacobiano Asta1 legata alla ruota
T = A1*A2;
p = T(1:3,4);
R = T(1:3,1:3);

%Jacobian Ruota
Jp_asta1 = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
               
dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);
TOR6vee = simplify(R'*dR_x6);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

Jo_asta1 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];
               
J_asta1 = [Jp_asta1;Jo_asta1];

%% Asta3
T = T*A3;
p = T(1:3,4);
R = T(1:3,1:3);

%Jacobian Ruota
Jp_asta2 = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
               
dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);
TOR6vee = simplify(R'*dR_x6);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

Jo_asta2 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];
               
J_asta2 = [Jp_asta2;Jo_asta2];

%% Asta4
T = T*A4;
p = T(1:3,4);
R = T(1:3,1:3);

%Jacobian Ruota
Jp_asta3 = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
               
dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);
TOR6vee = simplify(R'*dR_x6);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

Jo_asta3 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];
               
J_asta3 = [Jp_asta3;Jo_asta3];

%% Asta5
T = T*A5;
p = T(1:3,4);
R = T(1:3,1:3);

%Jacobian Ruota
Jp_asta4 = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                    jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
               
dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);
TOR6vee = simplify(R'*dR_x6);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

Jo_asta4 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];
               
J_asta4 = [Jp_asta4;Jo_asta4];

%% Asta6
T = T*A6;
p = T(1:3,4);
R = T(1:3,1:3);

%Jacobian Ruota
Jp_asta5 = simplify([jacobian(p(1),[x1,x2,x3,x4,x5,x6]);
                     jacobian(p(2),[x1,x2,x3,x4,x5,x6]);
                     jacobian(p(3),[x1,x2,x3,x4,x5,x6])]);
               
dR_x1 = diff(R,x1);
dR_x2 = diff(R,x2);
dR_x3 = diff(R,x3);
dR_x4 = diff(R,x4);
dR_x5 = diff(R,x5);
dR_x6 = diff(R,x6);

TOR1vee = simplify(R'*dR_x1);
TOR2vee = simplify(R'*dR_x2);
TOR3vee = simplify(R'*dR_x3);
TOR4vee = simplify(R'*dR_x4);
TOR5vee = simplify(R'*dR_x5);
TOR6vee = simplify(R'*dR_x6);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR6 = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

Jo_asta5 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR6];
               
J_asta5 = [Jp_asta5;Jo_asta5];


