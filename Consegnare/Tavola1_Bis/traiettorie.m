%%

theta0  = 10;	% rad
thetaf  = 30;
thetad0 = zeros(size(q_desiderata,1));% rad/Sec
thetadf = zeros(size(q_desiderata,1));
tstart  = 0;		% seconds
tfinal  = 1;
% find the coefficient of the 3rd order polynomial trajectory
[a3,a2,a1,a0] = createTraj3(cond_init,q_desiderata,thetad0,thetadf,tstart,tfinal);
% [a3,a2,a1,a0] = createTraj3(theta0,thetaf,thetad0,thetadf,tstart,tfinal);
% make a polynomial

p = [a3,a2,a1,a0];

% Create time vector
t = linspace(tstart,tfinal,500);

[q,dq,ddq] = generatore_traiettorie(p,t);

plot_trajectory(t,q,dq,ddq);

%%
q_traj.time = t;
q_traj.signals.values = q';
q_traj.signals.dimensions = 6;

dq_traj.time = t;
dq_traj.signals.values = dq';
dq_traj.signals.dimensions = 6;

