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