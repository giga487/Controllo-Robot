

%% PLOT FROM WORKSPACE

[r,~] = size(x.data);
time = x.time;

centro = [x.data(1) y.data(1)];

figure;
h = viscircles(centro,0.01);axis([-0.5 0.5 -0.5 0.5]);
viscircles([0 0],0.001);
asta = line([0 centro(1)],[0 centro(2)]);
grid on;
for i = 2:1:r
    dt = time(i)-time(i-1);
    centro = [x.data(i) y.data(i)];

    viscircles(centro,0.01);hold on;
    set(asta,'XData',[0 x.data(i)],'YData',[0 y.data(i)]);    
    pause(dt*0.01);
end