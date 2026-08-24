% Program 2.1
% Convolution of two sequences

clc; clear all; close all;
x1=[1 2 0 1];
x2=[2 2 1 1];
y=conv(x1,x2);
disp('the convolution output is');
disp(y);
subplot(3,1,1),stem(x1);
xlabel('Discrete time');
ylabel('Amplitude');
title('first input sequence');
subplot(3,1,2),stem(x2);
xlabel('Discrete time');
ylabel('Amplitude');
title('Second input sequence');
subplot(3,1,3),stem(y);
xlabel('Discrete time');
ylabel('Amplitude');
title('convolution output');

% Program 2.2
% Linear convolution via circular convolution

clc; clear all; close all;
x1=[1 2 3 4 5];
x2=[2 2 0 1 1];
x1e=[x1 zeros(1,length(x2)-1)];
x2e=[x2 zeros(1,length(x1)-1)];
ylin=cconv(x1e,x2e,length(x1e));
disp('linear convolution via circular convolution');
disp('ylin');
y=conv(x1,x2);
disp('Direct convolution');
disp(y);

% Program 2.3
% Linear convolution using DFT

clc; clear all; close all;
x=[1 2];
h=[2 1];
x1=[x zeros(1,length(h)-1)];
h1=[h zeros(1,length(x)-1)];
X=fft(x1);
H=fft(h1);
y=X.*H;
y1=ifft(y);
disp('the linear convolution of the given sequence');
disp(y1);

% Program 2.4
% Circular convolution using DFT based approach

clc; clear all; close all;
x1=[1 2 0 1];
x2=[2 2 1 1];
d4=[1 1 1 1;1 -j -1 j;1 -1 1 -1;1 j -1 -j];
x11=d4*x1';
x21=d4*x2';
X=x11.*x21;
x=conj((d4)*X/4);
disp('circular convolution by using DFT method');
disp(x);
x3=cconv(x1,x2,4);
disp('circular convolution by using time domain method');
disp(x3);

% Program 2.5
% Computation of correlation

x1=[1 3 0 4];
y=xcorr(x1,x1);
subplot(2,1,1);stem(x1);
xlabel('Discrete time');
ylabel('Amplitude');
title('input sequence');
subplot(2,1,2);stem(y);
title('Autocorrelation of the input sequence');
xlabel('Discrete time');
ylabel('Amplitude');