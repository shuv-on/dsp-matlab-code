% Program 3.1
% Z- transform and Inverse Z- transform of given signals

clc; clear all; close all;
syms n wo

% first signal
a = n+1;
disp('The input equation is');
disp(a);
b = ztrans(a);
disp('The z- transform is');
disp(b);
c = iztrans(b);
disp('The inverse z- transform is');
disp(c);

% second signal
a1 = cos(wo*n);
disp('The input equation is');
disp(a1);
b1 = ztrans(a1);
disp('The z- transform is');
disp(b1);
c1 = iztrans(b1);
disp('The inverse z- transform is');
disp(c1);

% Program 3.2
% Finding the residues of Z^3 / ((z - 0.5)*(z - 0.75)*(z - 1))

clc; clear all; close all;
syms z
d = (z - 0.5)*(z - 0.75)*(z - 1); % The denominator of F(z)
a1 = collect(d);
den = sym2poly(a1);
num = [0 1 0 0];
[num1,den1] = residue(num,den);
fprintf('r1 = %4.2f\t', num1(1));
fprintf('p1 = %4.2f\t', den1(1));
fprintf('r2 = %4.2f\t', num1(2));
fprintf('p2 = %4.2f\t', den1(2));
fprintf('r3 = %4.2f\t', num1(3));
fprintf('p3 = %4.2f\t', den1(3));

% Program 3.3
% Inverse Z- transform by the polynomial division method
% X(z) = (1 + 2*z^(-1) + z^(-2)) / (1 - z^(-1) + 0.3561*z^(-2))

clc; clear all; close all;
b=[1 2 1];
a=[1 -1 0.3561];
n=5; %number of power series points
b=[b zeros(1,n-1)];
[h,r]=deconv(b,a);
disp('The terms of inverse z- transforms');
disp(h);

% Program 3.4
% Inverse z- transform for the cascaded form using polynomial division method
% x(z)=[N1(z)*N2(z)*N3(z)]/[D1(z)*D2(z)*D3(z)]
% N1(z)=1- 0.22346Z^(-1)+z^(-2)
% N2(z)=1- 0.437883Z^(-1)+z^(-2)
% N3(z)=1+z^(-1)
% D1(z)=1- 1.433509Z^(-1)+0.858112Z^(-2)
% D2(z)=1- 1.293601Z^(-1)+0.556929z^(-2)
% D3(z)=1- 0.612159Z^(-1)

clc; clear all; close all;
n=5; % number of power series points
n1=[1 -0.22346 1];
n2=[1 -0.4377883 1];
n3=[1 1 0];
d1=[1 -1.433509 0.85811];
d2=[1 -1.293601 0.556929];
d3=[1 -0.612159 0];
b=[n1; n2; n3];
a=[d1; d2; d3];
[b,a]=sos2tf([b a]);
b=[b zeros(1,n-1)];
[x r]=deconv(b,a);
disp('The first five values of inverse Z- transform are');
disp(x);

% Program 3.5
% Pole- zero plot of a Butterworth band pass filter

clc; clear all; close all;
fs=1000; %sampling frequency
alpha=3;
alphas=20;
wp=[200/500 300/500];
ws=[50/500 450/500];
[n wc]=buttord(wp,ws,alpha,alphas);
[z p k]=butter(n,wp);
zplane(z,p);
title('Pole Zero plot');

% Program 3.6
% Convolution using Z-transform

clc; clear all; close all;
x1=[2 1 0 -1 3]; % x1=2+z^(-1)- z^(-3)+3*z^(-4)
x2=[1 -3 2]; % x2=1- 3*z^(-1)+2*z^(-2)
x3=conv(x1,x2); % x3=x1*x2;