
function [Jp,Jo] = genera_J(T)
    syms x1 x2 x3
    
    p = T(1:3,4)
    R = T(1:3,1:3)
    
    JacobianP = simplify([jacobian(p(1),[x1,x2,x3]);
                          jacobian(p(2),[x1,x2,x3]);
                          jacobian(p(3),[x1,x2,x3])])
         
    
end