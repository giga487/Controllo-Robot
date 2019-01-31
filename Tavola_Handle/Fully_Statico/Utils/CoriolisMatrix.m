

function C = CoriolisMatrix(B,q,dq)

    [r,c] = size(B);
    [rq, cq] = size(q);
    sym C real
    syms e real 
    b = 0.5;
   
    for i = 1:1:r
        for j = 1:1:c
            for k = 1:1:rq
               e(k) = b*(diff(B(i,j),q(k)) + diff(B(i,k),q(j)) - diff(B(j,k),q(i)))*dq(k);
            end
            C(i,j) = sum(e);
        end

    end
    
    
end