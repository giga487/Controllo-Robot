
function plot_graficiSIM(x,y,ref,string,xlab,ylab)

figure;
plot(x,y,'k',x,ref,'r');
title(sprintf('%s',string));
xlabel(sprintf('%s',xlab));
ylabel(sprintf('%s',ylab));
grid on;

end