%%Determine the letteral Jacobian

syms a1 a2 a3 a5 a4 a_head x1 x2 x3 x4 x5 x_head ...
    kr Ixx_b Iyy_b Izz_b...
    m_b1 m_b2 m_b3 m_b4 m_b5 m_b6 dx1 dx2 dx3 dx4 dx5 dx_head g0 ...
    ddx1 ddx2 ddx3 ddx4 ddx5 ddx_head real

kr = 1;
% a1 = param(1,1);
% a2 = param(2,1);
% a3 = param(3,1);
% a4 = param(4,1);
% a5 = param(5,1);
% a_head = param(6,1);
% 
% m_b1 = param(1,2);
% m_b2 = param(2,2);
% m_b3 = param(3,2);
% m_b4 = param(4,2);
% m_b5 = param(5,2);
% m_b6 = param(6,2);

q = [x1 x2 x3 x4 x5 x_head];
dq = [dx1 dx2 dx3 dx4 dx5 dx_head];

h = 0.1;
L = 1;

g0 = 9.81;

% Ixx_b = m_b1*(h^2)/12;
% Iyy_b = m_b1*(L^2)/12;
% Izz_b = m_b1*(h^2+L^2)/12;


I_braccio1 = [m_b1*(h^2)/12,0,0;
            0,m_b1*(L^2)/12,0;
            0,0,m_b1*(h^2+L^2)/12];
        
I_braccio2 = [m_b2*(h^2)/12,0,0;
              0,m_b2*(L^2)/12,0;
              0,0,m_b2*(h^2+L^2)/12];

I_braccio3 = [m_b3*(h^2)/12,0,0;
              0,m_b3*(L^2)/12,0;
              0,0,m_b3*(h^2+L^2)/12];
          
I_braccio4 = [m_b4*(h^2)/12,0,0;
              0,m_b4*(L^2)/12,0;
              0,0,m_b4*(h^2+L^2)/12];
          
I_braccio5 = [m_b5*(h^2)/12,0,0;
              0,m_b5*(L^2)/12,0;
              0,0,m_b5*(h^2+L^2)/12];
          
I_braccio6 = [m_b6*(h^2)/12,0,0;
              0,m_b6*(L^2)/12,0;
              0,0,m_b6*(h^2+L^2)/12];

        %% BRACCIO 1

TG1 = matrixDH(a1/2,0,0,x1);
pG1 = TG1(1:3,4);
rG1 = TG1(1:3,1:3);

p = pG1;
r = rG1;

JpG1 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(2),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(3),[x1,x2,x3,x4,x5,x_head]);];
%JoG1    
dR_x1 = diff(r,x1);
dR_x2 = diff(r,x2);
dR_x3 = diff(r,x3);
dR_x4 = diff(r,x4);
dR_x5 = diff(r,x5);
dR_xhead = diff(r,x_head);

TOR1vee = simplify(r'*dR_x1);
TOR2vee = simplify(r'*dR_x2);
TOR3vee = simplify(r'*dR_x3);
TOR4vee = simplify(r'*dR_x4);
TOR5vee = simplify(r'*dR_x5);
TOR6vee = simplify(r'*dR_xhead);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR_Head = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JoG1 =  simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head]);     
 

%% BRACCIO 2

TG2 = TG1*matrixDH(a2/2,0,0,x2);
pG2 = TG2(1:3,4);
rG2 = TG2(1:3,1:3);

p = pG2;
r = rG2;

JpG2 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(2),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(3),[x1,x2,x3,x4,x5,x_head]);];
%JoG2    
dR_x1 = diff(r,x1);
dR_x2 = diff(r,x2);
dR_x3 = diff(r,x3);
dR_x4 = diff(r,x4);
dR_x5 = diff(r,x5);
dR_xhead = diff(r,x_head);

TOR1vee = simplify(r'*dR_x1);
TOR2vee = simplify(r'*dR_x2);
TOR3vee = simplify(r'*dR_x3);
TOR4vee = simplify(r'*dR_x4);
TOR5vee = simplify(r'*dR_x5);
TOR6vee = simplify(r'*dR_xhead);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR_Head = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JoG2 =  simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head]);     

%% BRACCIO 3

TG3 = TG2*matrixDH(a3/2,0,0,x3);
pG3 = TG3(1:3,4);
rG3 = TG3(1:3,1:3);

p = pG3;
r = rG3;

JpG3 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(2),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(3),[x1,x2,x3,x4,x5,x_head]);];
%JoG1    
dR_x1 = diff(r,x1);
dR_x2 = diff(r,x2);
dR_x3 = diff(r,x3);
dR_x4 = diff(r,x4);
dR_x5 = diff(r,x5);
dR_xhead = diff(r,x_head);

TOR1vee = simplify(r'*dR_x1);
TOR2vee = simplify(r'*dR_x2);
TOR3vee = simplify(r'*dR_x3);
TOR4vee = simplify(r'*dR_x4);
TOR5vee = simplify(r'*dR_x5);
TOR6vee = simplify(r'*dR_xhead);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR_Head = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JoG3 =  simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head]);     

%% BRACCIO 4

TG4 = TG3*matrixDH(a4/2,0,0,x4);

pG4 = TG4(1:3,4);
rG4 = TG4(1:3,1:3);

p = pG4;
r = rG4;

JpG4 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(2),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(3),[x1,x2,x3,x4,x5,x_head]);];
%JoG4    
dR_x1 = diff(r,x1);
dR_x2 = diff(r,x2);
dR_x3 = diff(r,x3);
dR_x4 = diff(r,x4);
dR_x5 = diff(r,x5);
dR_xhead = diff(r,x_head);

TOR1vee = (r'*dR_x1);
TOR2vee = (r'*dR_x2);
TOR3vee = (r'*dR_x3);
TOR4vee = (r'*dR_x4);
TOR5vee = (r'*dR_x5);
TOR6vee = (r'*dR_xhead);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR_Head = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JoG4 =  simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head]);     

%% BRACCIO 5

TG5 = TG4*matrixDH(a5/2,0,0,x5);

pG5 = TG5(1:3,4);
rG5 = TG5(1:3,1:3);

p = pG5;
r = rG5;

JpG5 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(2),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(3),[x1,x2,x3,x4,x5,x_head]);];
%JoG1    
dR_x1 = diff(r,x1);
dR_x2 = diff(r,x2);
dR_x3 = diff(r,x3);
dR_x4 = diff(r,x4);
dR_x5 = diff(r,x5);
dR_xhead = diff(r,x_head);

TOR1vee = (r'*dR_x1);
TOR2vee = (r'*dR_x2);
TOR3vee = (r'*dR_x3);
TOR4vee = (r'*dR_x4);
TOR5vee = (r'*dR_x5);
TOR6vee = (r'*dR_xhead);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR_Head = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JoG5 = simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head]);     

%% HEAD Baricentro

TGHead = TG2*matrixDH(a_head/2,0,0,x_head);

pGHead= TGHead(1:3,4);
rGHead= TGHead(1:3,1:3);

p = pGHead;
r = rGHead;

JpGHead = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(2),[x1,x2,x3,x4,x5,x_head]);
        jacobian(p(3),[x1,x2,x3,x4,x5,x_head]);];
%JoG1    
dR_x1 = diff(r,x1);
dR_x2 = diff(r,x2);
dR_x3 = diff(r,x3);
dR_x4 = diff(r,x4);
dR_x5 = diff(r,x5);
dR_xhead = diff(r,x_head);

TOR1vee = (r'*dR_x1);
TOR2vee = (r'*dR_x2);
TOR3vee = (r'*dR_x3);
TOR4vee = (r'*dR_x4);
TOR5vee = (r'*dR_x5);
TOR6vee = (r'*dR_xhead);

TOR1 = [TOR1vee(3,2);TOR1vee(1,3);TOR1vee(2,1)];
TOR2 = [TOR2vee(3,2);TOR2vee(1,3);TOR2vee(2,1)];
TOR3 = [TOR3vee(3,2);TOR3vee(1,3);TOR3vee(2,1)];
TOR4 = [TOR4vee(3,2);TOR4vee(1,3);TOR4vee(2,1)];
TOR5 = [TOR5vee(3,2);TOR5vee(1,3);TOR5vee(2,1)];
TOR_Head = [TOR6vee(3,2);TOR6vee(1,3);TOR6vee(2,1)];

JoGHead =  simplify([TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head]);     

%% Matrice B

BJoint = (m_b1*(JpG1')*JpG1 + (JoG1')*rG1*I_braccio1*(rG1')*JoG1+...
        m_b2*(JpG2')*JpG2 + (JoG2')*rG2*I_braccio2*(rG2')*JoG2+...
        m_b3*(JpG3')*JpG3 + (JoG3')*rG3*I_braccio3*(rG3')*JoG3+...
        m_b4*(JpG4')*JpG4 + (JoG4')*rG4*I_braccio4*(rG4')*JoG4+...
        m_b5*(JpG5')*JpG5 + (JoG5')*rG5*I_braccio5*(rG5')*JoG5+...
        m_b6*(JpGHead')*JpGHead + (JoGHead')*rGHead*I_braccio6*(rGHead')*JoGHead);
 

B = simplify(BJoint);

% diary ('B.txt');
% B % your symbolic variable
% diary off

%% Coriolis
 
C = simplify(CoriolisMatrix(B,q,dq));

% diary ('C.txt');
% C % your symbolic variable
% diary off
 
%% Gravity

g = [0,-g0,0]';

GJoint = -(m_b1*(JpG1')*g+m_b2*(JpG2')*g+m_b3*(JpG3')*g+m_b4*(JpG4')*g+...
     m_b5*(JpG5')*g+m_b6*(JpGHead')*g);

G = simplify(GJoint);

% diary ('G.txt');
% G % your symbolic variable
% diary off
 
%% Dynamic

q = [x1 x2 x3 x4 x5 x_head];
dq = [dx1 dx2 dx3 dx4 dx5 dx_head];
ddq = [ddx1 ddx2 ddx3 ddx4 ddx5 ddx_head];

[~,n] = size(q);

dynamic = B*ddq.' + C*dq.'+ G;

dynamic = simplify(dynamic);


