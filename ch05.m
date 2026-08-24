% Program 5.1
% Fourier transform and Inverse Fourier transform of a given sequence

clc; clear all; close all;
syms x;
f = exp(-x^2);
disp('The input equation is');
disp(f);
a = fourier(f);
disp('The fourier transform of the input equation is');
disp(a);
b = fourier(a);
disp('The Inverse fourier transform is');
disp(b);

% Program 5.2
% Fourier transform of a signal % u(t+0.5)- u(t- 0.5)

clc; close all; clear all;
syms t w
a = heaviside(t + 0.5) - heaviside(t - 0.5);
subplot(2,1,1), ezplot(a, [-3 3]);
b = fourier(a);
subplot(2,1,2); ezplot(b, [-50 50]);
axis([-50 50 -1 2]);

% Program 5.3
% Evaluation and plotting of DTFT of the transfer function of the form a = e^(-jw)
% h(e) = [1 + 2*a^(-1)] / [1 - 0.2*a^(-1)]

clc; clear all; close all;
w=-2*pi:8*pi/511:2*pi;
num=[1 2];
den=[1 -0.2];
h=freqz(num,den,w);
subplot(2,1,1);plot(w/pi,real(h));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('Real part of the transfer function');
subplot(2,1,2);plot(w/pi,imag(h));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('Imaginary part of the transfer function');

figure;
subplot(2,1,1);plot(w/pi,abs(h));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('Magnitude spectrum of the transfer function');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized frequency');
ylabel('phase');
title('phase of the transfer function');

% Program 5.4
% Time shifting property of DTFT

clc; clear all; close all;
w=-pi:2*pi/255:pi;
d=10;
num=1:15;
h1=freqz(num,1,w);
a=[zeros(1,d) num]; % shifting
h2=freqz(a,1,w);
subplot(2,1,1);plot(w/pi,abs(h1));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the original sequence');
subplot(2,1,2); plot(w/pi,abs(h2));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the time shifted sequence');

figure;
subplot(2,1,1);plot(w/pi,angle(h1));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the original sequence');
subplot(2,1,2);plot(w/pi,angle(h2));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the time shifted sequence');

% Program 5.5
% Frequency shifting property of DTFT

clc; clear all; close all;
w=-pi:2*pi/255:pi;
wo=0.2*pi;
num1=[1 3 5 7 5 11 13 17 18 21 12];
I=length(num1);
h1=freqz(num1,1,w);
n=0:I-1;
num2=exp(wo*i*n).*num1;
h2=freqz(num2,1,w);
subplot(2,1,1);plot(w/pi,abs(h1));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the original sequence');
subplot(2,1,2);plot(w/pi,abs(h2));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the Frequency shifted sequence');

figure;
subplot(2,1,1);plot(w/pi,angle(h1));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the original sequence');
subplot(2,1,2);plot(w/pi,angle(h2));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the Frequency shifted sequence');

% Program 5.6
% Time convolution property of DTFT

clc; clear all; close all;
w=-2*pi:2*pi/255:2*pi;
x1=[1 3 5 7 5 11 13 17 18 21 12];
x2=[1 -2 3 -2 1];
y=conv(x1,x2);
h1=freqz(x1,1,w);
h2=freqz(x2,1,w);
h=h1.*h2;
h3=freqz(y,1,w);
subplot(2,1,1); plot(w/pi,abs(h));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the product sequence');
subplot(2,1,2); plot(w/pi,abs(h3));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the convolved sequence');

figure;
subplot(2,1,1);plot(w/pi,angle(h));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the product sequence');
subplot(2,1,2);plot(w/pi,angle(h3));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the convolved sequence');

% Program 5.7
% Time reversal property of DTFT

clc; clear all; close all;
w=-2*pi:2*pi/255:2*pi;
num=[1 2 3 4 5 6];
I=length(num)-1;
h1=freqz(num,1,w);
h2=freqz(fliplr(num),1,w);
h3=exp(w*I*i).*h2;
subplot(2,1,1); plot(w/pi,abs(h1));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the original sequence');
subplot(2,1,2);plot(w/pi,abs(h3));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum of the time- reversed sequence');

figure;
subplot(2,1,1); plot(w/pi,angle(h1));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the original sequence');
subplot(2,1,2); plot(w/pi,angle(h3));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum of the time- reversed sequence');

% Program 5.8
% Frequency response of the given system

clc; clear all; close all;
num = [1 -1 3];
den = [1 1/3 1/6];
[h,om] = freqz(num,den);
subplot(2,1,1);plot(om/pi,20*log10(abs(h)));
xlabel('normalized frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(om/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 5.9
% Periodicity property of DTFT

clc; clear all; close all;
n = 1:10;
x = (0.9*exp(i*pi/3)).^n;
k = -200:200;
w = (pi/100)*k;
x1 = x*exp(-i*pi/100).^(n'*k);
subplot(2,1,1); plot(w/pi,abs(x1));
xlabel('Normalized frequency');
ylabel('Amplitude');
title('magnitude spectrum');
subplot(2,1,2); plot(w/pi,angle(x1));
xlabel('Normalized frequency');
ylabel('phase');
title('phase spectrum');