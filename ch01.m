% Program 1.1
% Generation of Elementary signals in Discrete- time

clc; close all; clear all;
% Unit Impulse sequence
n=-10:1:10;
impulse=[zeros(1,10),ones(1,1),zeros(1,10)];
subplot(2,2,1);stem(n,impulse);
xlabel('Discrete time n - - >');ylabel('Amplitude - - >');
title('Unit Impulse sequence');
axis([-10 10 0 1.2]);

% Unit Step sequence
n=-10:1:10;
step=[zeros(1,10),ones(1,11)];
subplot(2,2,2);stem(n,step);
xlabel('Discrete time n - - >');ylabel('Amplitude - - >');
title('Unit Step sequence');
axis([-10 10 0 1.2]);

% Unit Ramp sequence
n=0:1:10;
ramp=n;
subplot(2,2,3);stem(n,ramp);
xlabel('Discrete time n - - >');ylabel('Amplitude - - >');
title('Unit Ramp sequence');

% Unit Parabolic sequence
n=0:1:10;
parabola=0.5*(n.^2);
subplot(2,2,4);stem(n,parabola);
xlabel('Discrete time n - - >');ylabel('Amplitude - - >');
title('Unit Parabolic sequence');

% Program 1.2
% Generation of a Discrete- time exponential sequence

clc;close all;clear all;
n=-10:1:10;

% for 0<a<1
a=0.8;
x1=a.^n;
subplot(2,2,1);stem(n,x1);
title('x1(n)for 0<a<1');

% for a>1
a=1.5;
x2=a.^n;
subplot(2,2,2);stem(n,x2);
title('x2(n) for a>1');

% for -1<a<0
a=-0.8;
x3=a.^n;
subplot(2,2,3); stem(n,x3);
title('x3(n) for - 1<a<0');

% for a<- 1
a=-1.2;
x4=a.^n;
subplot(2,2,4); stem(n,x4);
title('x4(n) for a<- 1');
xlabel('samples n');
ylabel('sample amplitude');

% Program 1.3
% Multiplication of Discrete- time signals

clc;close all;clear all;
% x1(n)=6*a^n;
n = 0:0.1:5;
a = 2;
x1 = 6*(a.^n);
subplot(3,1,1); stem(n,x1);
title('x1(n)');

% x2(n)=2*cos(wn)
f=1.2;
x2=2*cos(2*pi*f*n);
subplot(3,1,2); stem(n,x2);
title('x2(n)');

% multiplication of two sequences
y=x1.*x2;
subplot(3,1,3); stem(n,y);
xlabel('time n');ylabel('amplitude');
title('y(n)');

% Program 1.4
% Even and Odd components of the sequence y(n)=u(n)- u(n- 10)

n=-15:1:15;
y1=[zeros(1,15),ones(1,10),zeros(1,6)];
y2=fliplr(y1);
ye=0.5*(y1+y2);
yo=0.5*(y1-y2);
subplot(2,2,1);stem(n,y1);
xlabel('time - - >');ylabel('Amplitude - - >');
title('y(n)');
subplot(2,2,2);stem(n,y2);
xlabel('time - - >');ylabel('Amplitude - - >');
title('y(- n)');
subplot(2,2,3);stem(n,ye);
xlabel('time - - >');ylabel('Amplitude - - >');
title('ye(n)');
subplot(2,2,4);stem(n,yo);
xlabel('time - - >');ylabel('Amplitude - - >');
title('yo(n)');

% Program 1.5
% Generation of the composite sequence x(n)=u(n+3)+5u(n-15)+4u(n+10)

clc;close all;clear all;
n=-20:1:20;
u=[zeros(1,20),ones(1,21)];
u1=[zeros(1,17),ones(1,24)];
u2=[zeros(1,35),ones(1,6)];u2=5*u2;
u3=[zeros(1,10),ones(1,31)];u3=4*u3;
x=u1+u2+u3;
subplot(4,1,1);stem(n,u1);
title('u(n+3)');
subplot(4,1,2);stem(n,u2);
title('5u(n-15)');
subplot(4,1,3);stem(n,u3);
title('4u(n+10)');
subplot(4,1,4);stem(n,x);
title('x(n)');

% Program 1.6
% Generation of swept frequency sinusoidal signal

clc; clear all; close all;
n = 0:100;
a = pi/2/100;
b = 0;
arg = a*n*n + b*n;
x = cos(arg);
stem(n,x);
xlabel('Discrete time');
ylabel('Amplitude');
title('Swept- frequency sinusoidal signal');

% Program 1.7
% Checking the Time-invariance property

clc; clear all; close all;
n = 0:40; D = 10;
x = 3*cos(2*pi*0.1*n) - 2*cos(2*pi*0.4*n);
xd = [zeros(1, D) x];
num = [2.2403 2.4908 2.2403];
den = [1 -0.4 0.75];
ic = [0 0];
y = filter(num,den,x,ic);
yd = filter(num,den,xd,ic);
d = y - yd(1+D:41+D);
subplot(3,1,1),stem(n,y);
xlabel('Discrete time');
ylabel('Amplitude');
title('output y[n]');
subplot(3,1,2), stem(n,yd(1:41));
xlabel('Discrete time');
ylabel('Amplitude');
title('output due to delayed input');
subplot(3,1,3), stem(n,d);
xlabel('Discrete time');
ylabel('Amplitude');
title('difference signal');

% Program 1.8
% Computation of impulse response

clc; clear all; close all;
N=40;
num=[2.2403 2.4908 2.2403];
den=[1 -0.4 0.75];
y=impz(num,den,N);
stem(y);
xlabel('Discrete time');
ylabel('Amplitude');
title('Impulse response of the filter');

% Program 1.9
% Checking the linearity of a system

clc; clear all; close all;
n = 0:50;
a = 2; b = -3;
x1 = cos(2*pi*0.1*n);
x2 = cos(2*pi*0.4*n);
x = a*x1 + b*x2;
num = [2.2403 2.4908 2.2403];
den = [1 -0.4 0.75];
ic = [0 0];
y1 = filter(num,den,x1,ic);
y2 = filter(num,den,x2,ic);
y = filter(num,den,x,ic);
yt = a*y1 + b*y2;
d = y - yt;
subplot(3,1,1);stem(n,y);
xlabel('Discrete time');
ylabel('Amplitude');
title('output due to weighted input');
subplot(3,1,2);stem(n,yt);
xlabel('Discrete time');
ylabel('Amplitude');
title('Weighted output');
subplot(3,1,3);stem(n,d);
xlabel('Discrete time');
ylabel('Amplitude');
title('difference signal');

% Program 1.10
% Testing the stability of a system

clc; clear all; close all;
num = [1 -0.8];
den = [1 1.5 0.9];
N=200;
h = impz(num,den,N+1);
parsum = 0;
for k = 1:N+1
    parsum = parsum + abs(h(k));
    if abs(h(k))<10^(-6)
        break;
    end
end
stem(h);
xlabel('Discrete time');
ylabel('Amplitude');
disp('Value=');
disp(abs(h(k)));