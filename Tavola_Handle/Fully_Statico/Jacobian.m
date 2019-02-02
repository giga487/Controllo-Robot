%Determine the letteral Jacobian
clc
clear

syms a1 a2 a3 a5 a4 a_head x1 x2 x3 x4 x5 x_head ...
    l_head kr Ixx_b Iyy_b Izz_b real

I_braccio = [Ixx_b,0,0;
            0,Iyy_b,0;
            0,0,Izz_b;];

I_mot = [Ixx_m,0,0;
          0,Iyy_m,0;
          0,0,Izz_m;];


angle0_1 = pi/6;
angle0_2 = 5*pi/6;
angle0_3 = -3*pi/5;
angle0_4 = 4*pi/5;
angle0_5 = pi/10;
angle0_head = -3*pi/4;

%% BRACCIO 1

TG1 = matrixDH(a1/2,0,0,x1+angle0_1);
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

JoG1 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     
 
%% MOTORE G1

TM1 = matrixDH(0,0,0,kr*x1+angle0_1);
pM1 = TM1(1:3,4);
rM1 = TM1(1:3,1:3);
p = pM1;
r = rM1;

JpM1 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
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

JoM1 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% BRACCIO 2

TG2 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2/2,0,0,x2+angle0_2);
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

JoG2 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% MOTORE 2

TM2 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(0,0,0,kr*x2+angle0_2);
pM2 = TM2(1:3,4);
rM2 = TM2(1:3,1:3);
p = pM2;
r = rM2;

JpM2 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
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

JoM2 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% BRACCIO 3

TG3 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_2)*...
      matrixDH(a3/2,0,0,x3+angle0_3);
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

JoG3 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% MOTORE 3

TM3 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_1)*...
      matrixDH(0,0,0,kr*x3+angle0_2);
pM3 = TM3(1:3,4);
rM3 = TM3(1:3,1:3);
p = pM3;
r = rM3;

JpM3 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
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

JoM3 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% BRACCIO 4

TG4 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_2)*...
    matrixDH(a3,0,0,x3+angle0_3)*matrixDH(a4/2,0,0,x4+angle0_4);

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

JoG4 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% MOTORE 4

TM4 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_2)*...
     matrixDH(a3,0,0,x3+angle0_3)*matrixDH(0,0,0,kr*x4+angle0_4);

pM4 = TM4(1:3,4);
rM4 = TM4(1:3,1:3);
p = pM4;
r = rM4;

JpM4 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
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

JoM4 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% BRACCIO 5

TG5 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x1+angle0_2)*...
     matrixDH(a3,0,0,x3+angle0_3)*matrixDH(a4,0,0,x4+angle0_4)*...
     matrixDH(a5/2,0,0,x5+angle0_5);

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

JoG5 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% MOTORE 5

TM5 = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_2)*...
     matrixDH(a3,0,0,x3+angle0_3)*matrixDH(a4,0,0,x4+angle0_4)*...
     matrixDH(0,0,0,kr*x5+angle0_5);

pM5 = TM5(1:3,4);
rM5 = TM5(1:3,1:3);
p = pM5;
r = rM5;

JpM5 = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
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

JoM5 =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];   

%% HEAD Baricentro

TGHead = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_2)*...
         matrixDH(a_head/2,0,0,x_head+angle0_head);

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

JoGHead =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];     

%% MOTORE 5

TMHead = matrixDH(a1,0,0,x1+angle0_1)*matrixDH(a2,0,0,x2+angle0_2)*...
         matrixDH(0,0,0,kr*x_head+angle0_head);

pMHead= TMHead(1:3,4);
rMHead = TMHead(1:3,1:3);
p = pMHead;
r = rMHead;

JpMHead = [jacobian(p(1),[x1,x2,x3,x4,x5,x_head]);
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

JoMHead =  [TOR1,TOR2,TOR3,TOR4,TOR5,TOR_Head];   

%% Dinamica
