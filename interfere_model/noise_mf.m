close all;
clear all;
clc;

fj = 20e6;
fmax = 40e6;
fnyq = 2*fmax;
dt = 1/fnyq;
Tr = 520e-6;
t = 0:dt:3*Tr-dt;
N = length(t);
df = fmax/N;
f =0:df:(N-1)*df;


mf =1;
bj = 1e6;

uj = 1;

un = wgn(1,N,0);
wp = 5e6;
ws = 10e6;
rp = 1;
rs = 60;
[n,wn] = buttord(wp/(fnyq/2),ws/(fnyq/2),rp,rs);
[a,b] = butter(n,wn);
u1 = filter(a,b,un);
p=0.8503*mean((u1.^2))  %计算过滤完信号的功率

i = 1:N-1;
ss = cumsum([0 u1(i)]);
ss = ss*Tr/N;


Kfm = mf*bj;
y_fm = uj*cos(2*pi*t*fj+2*pi*Kfm*ss*10+2);

figure%subplot(2,1,1),
plot(t,y_fm);set(gca, 'Fontname', 'Times New Roman','FontSize',12);%设置坐标刻度字体
xlabel('t(s)','Fontname', 'Times New Roman','FontSize',12);ylabel('Amplitude(V)','Fontname', 'Times New Roman','FontSize',12);xlim([0 160*(1/fnyq)]);grid on;%,title( '噪声调频信号波形'); %axis([0,160*(1/fs),-1.5,1.5])  
figure
set(gca, 'Fontname', 'Times New Roman','FontSize',12);%设置坐标刻度字体
periodogram(y_fm,[ ],length(y_fm),fnyq,'onesided');xlabel('Frequency(MHz)','Fontname', 'Times New Roman','FontSize',12);ylabel('Power/Frequency(dB/Hz)','Fontname', 'Times New Roman','FontSize',12);title( ' ');%title('噪声调频信号功率谱');
figure
n = 0:N-1;
J=fft(y_fm);plot(f,10*log10(abs(J(n+1))));xlabel('频率(Hz)');ylabel('功率（dBW）');title( '噪声调频信号功率谱')
