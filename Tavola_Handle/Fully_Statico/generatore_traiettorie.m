function [q,dq,ddq] = generatore_traiettorie(p_matrix,t)

    [r,c] = size(p_matrix);

    for i = 1:1:r
        
        p = p_matrix(i,:);
        % Evaluate the polynomial : Position
        pos = polyval(p,t);
        % calculate the first derivative : Velocity
        pd  = polyder(p);
        % Evaluate the velocity
        vel = polyval(pd,t);
        % calculate the second derivative : Acceleration
        pdd = polyder(pd);
        % Evaluate the acceleration
        acc = polyval(pdd,t);
        
        q(i,:) = pos;
        dq(i,:) = vel;
        ddq(i,:) = acc;
    end

end

