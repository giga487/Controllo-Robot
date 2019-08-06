A = [-sin(x(3)),cos(x(3)),0,0,0,0;
     cos(x(3)),sin(x(3)),b,0,-R,0;
     cos(x(3)),sin(x(3)),-b,0,0,-R]
 
S = simplify(null(A))
     
syms v1 v2 v3 d_alfa v d_theta
q_v = [d_alfa;v;d_theta];
q_v1 = [v1;v2;v3];

S*q_v

S1 = [0,cos(x(3)),0;
      0,sin(x(3)),0;
      0,0,1;
      1,0,0;
      0,1/R,b/R;
      0,1/R,-b/R];

S1*q_v1
