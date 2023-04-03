close all;
clear all;
clc;

fmax = 40e6;
fj = 20e6;
fnyq = 2*fmax;
Npts = 80000;
J = 10;

dt = 1/fnyq;
t = 0:dt:(Npts-1)*dt;

u = sqrt(2*J)*cos(2*pi*fj*t+3);
figure
plot(t,u);title('载波信号波形');xlabel('时间(s)');xlim([0 160*(1/fnyq)]);grid on;ylabel('幅度(V)');title('单音干扰信号波形');
figure
set(gca, 'Fontname', 'Times New Roman','FontSize',12);
periodogram(u,[ ],length(u),fnyq,'onesided');
xlabel('Frequency(MHz)','Fontname', 'Times New Roman','FontSize',12);
ylabel('Power/Frequency(dB/Hz)','Fontname', 'Times New Roman','FontSize',12);title( ' 单音干扰信号波形');
% plot(f(1:N/2),cxf(1:N/2));title('载波信号频谱'); axis([0 2000 0 1]);xlabel('频率(Hz)');ylabel('功率');title('单音干扰信号归一化功率谱');



