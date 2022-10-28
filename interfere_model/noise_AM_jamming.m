%%
clear,close all
%�������������ź�
%u0�����ز����ȣ�wj�����ز�����Ƶ��
%��Ҫ��һ��ʱ����

fj = 100e6; %fjΪ����Ƶ��
fs = 4*fj; %fsΪ����Ƶ��
Num = 80000;%ʱ������һ���ĵ���
t_axis = 0:1/fs:(Num-1)*(1/fs); %1/fs����ÿ����ļ��ʱ��


%���������ź�wgn(n,m,wdB) ���������n*m����˹�������ź�,wdB�������ɵ�������ǿ��
un = wgn(1,Num,3);

%����һ��Ƶ����
df1 = fs/Num;
f_axis = 0:df1:(Num-1)*(df1);

%�����˲���
%�԰�����˹�˲���Ϊ����[n,Wn] = buttord(Wp,Ws,Rp,Rs)
%Wp��ͨ����ֹƵ�ʣ�Ws�������ֹƵ��
%Rp����ͨ������ȵ�һ��������Rs�������������ȵ�һ������
%n��Wn�ֱ�����Ƶõ����˲����Ľ����ͽ�ֹƵ��
wp = 50e6; %�����趨��Ƶ��ֵ��������matlab�м���ʱҪ��Ӧ�����ϣ����Ժ���Ҫ��һ����һ��
ws = 80e6;
rp = 1;
rs = 60;
[n,wn] = buttord(wp/(fs/2),ws/(fs/2),rp,rs);%��һ����ʱ��Ҫ�õ�����Ƶ�ʵ�һ��

%�������ӻ�butterworthy�˲�������n��wn������butter������������һ��butterworthy
%[z,p,k] = butter(n,wn),n ���������wn�����ֹƵ��,z������㣬p����ֵ�㣬k��������
[a,b] = butter(n,wn);

%���˲�����ԭ�����ɵ������źŽ����˲�
%filter��p,q,x��,p����0�㣬q�����㣬x�����˲����ź�����
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