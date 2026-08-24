% Program 7.1
% Calculation of the DFT of a given sequence using FFT

clc; clear all; close all;
x = [2 2 2 2 1 1 1 1];
y = fft(x);
disp('the fft of the input sequence');
disp(y);

y1=abs(y);
subplot(2,1,1),stem(y1);
title('magnitude response');

y2=angle(y);
subplot(2,1,2),stem(y2);
title('phase response');

y3=ifft(y);
disp('the inverse fft is');
disp(y3);

% Program 7.2
% Linear convolution using FFT

clc; clear all; close all;
x = [1 2];
h = [2 1];
x1 = [x zeros(1, length(h)-1)];
h1 = [h zeros(1, length(x)-1)];
X = fft(x1);
H = fft(h1);
y = X.*H;
y1 = ifft(y);
disp('the linear convolution of the given sequence');
disp(y1);

% Program 7.3
% Circular convolution using FFT

clc; clear all; close all;
x = [1 2 1 2];
h = [4 3 2 1];
X = fft(x);
H = fft(h);
y = X.*H;
y1 = real(ifft(y));
disp('the circular convolution of the given sequence');
disp(y1);

% Program 7.4
% Plotting of DFT of sinusoidal wave

clc; clear all; close all;
t = 0:0.01:1;
a = sin(2*pi*10*t) + sin(2*pi*100*t);
b = fft(a);
c = abs(b);
d = length(a);
e = c/d;
subplot(2,1,1), plot(t,a);
xlabel('time');
ylabel('amplitude');
title('input signal');
subplot(2,1,2), plot(e);
xlabel('frequency');
ylabel('amplitude');
title('fft of the input signal');