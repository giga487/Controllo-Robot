% Script to generate symbolic regressor model
% Results can be copied and pasted in matlab functions for 
% further use

% IMPORTANT: remember to put parameter variables as symbolic in the init function
% before execute this

syms a
regressor = a*zeros(n,2); % just to make Y symbolic

for i=1:n
    [c t] = coeffs(dynamic(i), m5);
    
    if size(t,2)==2
        regressor(i,:) = c;
    else
        if t==1
            regressor(i,1) = 0;
            regressor(i,2) = c;
        else
            regressor(i,1) = c;
            regressor(i,2) = 0;
        end
    end
    
end

regressor = simplify(regressor);

% test to vefiry that B.ddq + C.dq + G + Fv.dq = Y.pi

test = simplify(dynamic-regressor*[m5;1]);

if any(test~=0)
    error('error in regressor computation')
end