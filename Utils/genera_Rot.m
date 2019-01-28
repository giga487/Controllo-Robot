function R = genera_Rot(x1,x2,x3)

L = 5;

T01 = [Rz_rad(x1),[0;0;0];
      [0,0,0,1]];
T12 = [Ry_rad(x2),[0;0;0];
      [0,0,0,1]];
T23 = [Rz_rad(x3),[0;0;0];
      [0,0,0,1]];
 
Ttrasl = [eye(3),[0;0;L];
         [0,0,0,1]];
  
R = T01*T12*T23*Ttrasl;

end