close all;
clear all;
clc;

fmax = 40e6;
fj = 20e6;
fnyq = 2*fmax;
Npts = 80000;
dt = 1/fnyq;
t = 0:dt:(Npts-1)*dt;
J = 10;

step = 2e6;
% ff = fj-5e6:step:fj+5e6;
u = zeros(1,Npts);
for i = -3:3
u = u + sqrt(J)*cos(2*pi*(fj+i*step)*t+2);
end

figure
plot(t,u);xlabel('时间(s)');xlim([0 160*(1/fnyq)]);grid on;ylabel('幅度(V)');title('多音干扰信号波形');
figure
set(gca, 'Fontname', 'Times New Roman','FontSize',12);
periodogram(u,[ ],length(u),fnyq,'onesided');
xlabel('Frequency(MHz)','Fontname', 'Times New Roman','FontSize',12);
ylabel('Power/Frequency(dB/Hz)','Fontname', 'Times New Roman','FontSize',12);title( ' 多音干扰信号波形');