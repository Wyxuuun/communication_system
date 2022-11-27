%%
clear,close all
%噪声调幅干扰信号
%噪声调幅信号利用噪声作为调制信号，对载波信号进行AM调制，使载波信号的振幅随基带噪声做随机变化


%u0代表载波幅度，wj代表载波中心频率
%先要做一个时间轴

fj = 100e6; %fj为中心频率
fs = 4*fj; %fs为采样频率
Num = 80000;%时间轴上一共的点数
t_axis = 0:1/fs:(Num-1)*(1/fs); %1/fs代表每个点的间隔时间


%基带噪声信号wgn(n,m,wdB) 代表输出（n*m）高斯白噪声信号,wdB代表生成的噪声的强度
un = wgn(1,Num,3);

%构造一个频率轴
df1 = fs/Num;
f_axis = 0:df1:(Num-1)*(df1);

%构建滤波器
%以巴特沃斯滤波器为例，[n,Wn] = buttord(Wp,Ws,Rp,Rs)
%Wp是通带截止频率，Ws是阻带截止频率
%Rp描述通带起伏度的一个参量，Rs是描述阻带起伏度的一个参量
%n，Wn分别是设计得到的滤波器的阶数和截止频率
wp = 50e6; %这里设定的频率值，但是在matlab中计算时要对应到点上，所以后面要做一个归一化
ws = 80e6;
rp = 1;
rs = 60;
[n,wn] = buttord(wp/(fs/2),ws/(fs/2),rp,rs);%归一化的时候要用到采样频率的一半

%如果想可视化butterworthy滤波器，用n和wn，再用butter函数逆向生成一个butterworthy
%[z,p,k] = butter(n,wn),n 代表阶数，wn代表截止频率,z代表零点，p代表极值点，k代表增益
[a,b] = butter(n,wn);

%用滤波器对原来生成的噪声信号进行滤波
%filter（p,q,x）,p代表0点，q代表极点，x代表被滤波的信号序列
u1 = filter(a,b,un);



u0 = sqrt(10);
y = (u0 + u1).*cos(2*pi*fj*t_axis+2);


figure(1)
subplot(211)
plot(t_axis,u1);
hold on;
subplot(212);

plot(f_axis,20*log10(abs(fftshift((fft(u1))))));
%plot(f_axis,20*log10(abs((fft(u1)))));
hold on;








%%
