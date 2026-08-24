% Program 6.1
% Fourier series representation of a train of pulses

clc; clear all; close all;
syms t % symbolic Fourier Series computation
T0 = 1; % T0: period
m = heaviside(t) - heaviside(t - T0/4) + heaviside(t - 3*T0/4);
x = 2 * m; % periodic signal

N=20; % N: number of harmonics

% computation of N Fourier series coefficients
for k = 1:N
    X1(k) = int(x*exp(-j*2*pi*(k-1)*t/T0), t, 0, T0)/T0;
    X(k) = subs(X1(k));
    w(k) = (k-1)*2*pi/T0; % harmonic frequencies
end

ezplot(x,[0 T0]),grid;
title('input sequence');
figure;
subplot(2,1,1), stem(w,abs(X));
title('magnitude of fourier series');
subplot(2,1,2), stem(w,angle(X));
title('phase of fourier series');

% Program 6.2
% Fourier series representation of a full wave rectified wave

clc; clear all; close all;
syms t
T0 = 1;
m = heaviside(t) - heaviside(t - T0);
x = abs(cos(pi*t)) * m;
N=20;

% computation of N Fourier series coefficients
for k = 1:N
    X1(k) = int(x*exp(-j*2*pi*(k-1)*t/T0), t, 0, T0)/T0;
    X(k) = subs(X1(k));
    w(k) = (k-1)*2*pi/T0; % harmonic frequencies
end

ezplot(x,[0 T0]);grid;
title('input sequence');
figure;
subplot(2,1,1);stem(w,abs(X));
title('magnitude of fourier series');
subplot(2,1,2); stem(w,angle(X));
title('phase of fourier series');

% Program 6.3
% Direct computation of Discrete Fourier transform (matrix formulation)

clc; clear all; close all;
x=[1 -1 2 -2];
I=length(x);
y=x*dfmtx(I);
disp('the discrete fourier transform of the input sequence is');
disp(y);
I1=length(y);
y1=y*conj(dfmtx(I1))/I1;
disp('the Inverse discrete fourier transform of the input sequence is');
disp(y1);

% Program 6.4
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

% Program 6.5
% Circular convolution using DFT

clc; clear all; close all;
x = [1 2 1 2];
h = [4 3 2 1];
X = fft(x);
H = fft(h);
y = X.*H;
y1 = real(ifft(y));
disp('the circular convolution of the given sequence');
disp(y1);

% Program 6.6
% Relation between DFTs of the periodic even and odd parts of a real sequence

clc; clear all; close all;
x = [1 2 4 2 6 32 6 4 2 zeros(1,247)];
x1 = [x(1) x(256:-1:2)];
xe = 0.5*(x + x1);
xf = fft(x);
xef = fft(xe);
k = 0:255;
subplot(2,1,1),plot(k/128,real(xf));
title('real part of DFT sequence');
subplot(2,1,2), plot(k/128,imag(xf));
title('imaginary part of DFT sequence');
figure;
subplot(2,1,1), plot(k/128,real(xef));
title('real part of DFT even sequence');
subplot(2,1,2), plot(k/128,imag(xef));
title('imaginary part of DFT even sequence');

% Program 6.7
% Parseval's relation of DFT
% sum(x(t)^2)=(1/N)*(sum(x(w)).^2)

clc; clear all; close all;
x=[(1:128) (128:-1:1)];
y=fft(x);
y1=sum(x.*x);
y2=length(x);
y3=abs(y);
y4=[sum(y3.*y3)]/y2;
y5=y1-y4;
disp('energy in time domain');
disp(y1);
disp('energy in Frequency domain');
disp(y4);
disp('error');
disp(y5);

% Program 6.8
% Circular time shifting property of DFT

clc; clear all; close all;
x = [0 2 4 6 8 10 12 14 16];
N = length(x) - 1;
n = 0:N;
M = 5; % Samples

if abs(M) > length(x)
    M = rem(M,length(x));
end
if M < 0
    M = M + length(x);
end

y = [x(M+1:length(x)) x(1:M)];
xf = fft(x);
yf = fft(y);
subplot(2,1,1), stem(n, abs(xf));
title('Magnitude of DFT original sequence');
subplot(2,1,2), stem(n, abs(yf));
title('Magnitude of DFT Circularly shifted sequence');
figure;
subplot(2,1,1), stem(n, angle(xf));
title('Phase of DFT original sequence');
subplot(2,1,2), stem(n, angle(yf));
title('phase of DFT Circularly shifted sequence');

% Program 6.9
% Gibbs phenomenon

clc; clear all; close all;
t = 0:.1:10;
y1 = sin(t);
plot(t,y1);
y2 = sin(t) + sin(3*t)/3;
figure;plot(t,y2);
y3 = sin(t) + sin(3*t)/3 + sin(5*t)/5;
figure;plot(t,y3);
y4 = sin(t) + sin(3*t)/3 + sin(5*t)/5 + sin(7*t)/7;
figure;plot(t,y4);

t = 0:0.2:3.14;
y = zeros(10,length(t));
x = zeros(size(t));
for k=1:2:19
    x = x + sin(k*t)/k;
    y((k+1)/2,:) = x;
end
figure;plot(y(1:2:9,:)');
title('The building of a square wave: Gibbs effect');