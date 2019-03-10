function T2 = T2(x1,x2)

        syms L real
        
        TA = [Rz_rad(x1),[0,0,0]';
             [0,0,0],1];
        TB = [eye(3),[0,L,0]';
             [0,0,0],1];
        TC = [Rz_rad(x2),[0,0,0]';
             [0,0,0],1];
        
        
        T2 = simplify(TA*TB*TC);
        

end