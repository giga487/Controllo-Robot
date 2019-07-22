function [pos, vel, acc] = off_traj(theta0, thetaf, thetad0, thetadf,...
                                    thetadd0, thetaddf,tstart,tfinal,n_t) 

% theta0      = 10*pi/180;	% rad
% thetaf      = 30*pi/180;
% thetad0     = 0;            % rad/Sec
% thetadf     = 0;
% thetadd0    = 0;            % rad/Sec
% thetaddf    = 0;
% tstart      = 0;            % seconds
% tfinal      = 1;

[a5,a4,a3,a2,a1,a0] = createTraj5(theta0,thetaf,thetad0,thetadf,...
                                  thetadd0,thetaddf,tstart,tfinal);

% make a polynomial
p   = [a5,a4,a3,a2,a1,a0];
% Create time vector
t   = linspace(tstart,tfinal,n_t);
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
% plot
% figure;
% plot(t,pos,'--+r'); hold on
% plot(t,vel,'--og'); hold on
% plot(t,acc,'--xb'); hold on
% legend('Position','Velocity','Acceleration');
% grid