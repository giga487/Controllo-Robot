% plot3D_InvertedPendulum


%% PLOT FROM WORKSPACE x uscente, y laterale, z altezza

[r,~] = size(Y.data);
time = Y.time;

centro = [Y.data(1) Z.data(1)];

figure;
subplot(3,1,1);
plot(x1);
subplot(3,1,2);
plot(x2);
subplot(3,1,3);
plot(x3);

figure;
h = viscircles(centro,0.01);axis([-0.5 0.5 -0.5 0.5]);
viscircles([0 0],0.001);
asta = line([0 centro(1)],[0 centro(2)]);
grid on;
for i = 2:1:r
    dt = time(i)-time(i-1);
    centro = [Y.data(i) Z.data(i)];
    delete(h)
    h = viscircles(centro,0.01);hold on;
    set(asta,'XData',[0 Y.data(i)],'YData',[0 Z.data(i)]);    
    pause(dt*0.01);
end




