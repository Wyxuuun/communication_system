close all;
clear all;
clc;

fmax = 40e6;
fj = 20e6;
fnyq = 2*fmax;

t = 0:0.00001:3-0.00001;

f_start = 10e6;
f_end = 30e6;

% x = chirp(mod(t,1),f_start,1,f_end);
% figure
% plot(t,x);title('线性扫频信号是时域图');xlabel('时间(s)');ylabel('幅度(V)');

f = f_start+(f_end-f_start)*mod(t,1);
figure
plot(t,f);title('线性扫频信号频率-时间图');xlabel('时间(s)');ylabel('频率(Hz)');



