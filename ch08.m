% Program 8.1
% Design of filter using Bilinear Transformation

clc; clear all; close all;
fs=1000; % sampling frequency
fn=fs/2;
fc=300; % cutoff frequency
n=5;
[z,p,k]=butter(n,fc/fn);
b=k*poly(z); % zeros
a=poly(p); % poles
[h,om]=freqz(b,a,512,fs);
subplot(2,1,1),plot(om,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2),plot(om,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.2
% Butterworth low- pass filter

clc; clear all; close all;
alphas = 30; % pass band attenuation in dB
alphap = 0.5; % stop band attenuation in dB
fpass = 1000; % pass band frequency in Hz
fstop = 1500; % stop band frequency in Hz
fsam = 5000; % sampling frequency in Hz

wp = 2*fpass/fsam;
ws = 2*fstop/fsam; % pass band and stop band frequencies
[n,wn] = buttord(wp,ws,alphap,alphas); % minimal order, half- power frequency
[b,a] = butter(n,wn); % coefficients of designed filter
[h,w] = freqz(b,a);
subplot(2,1,1);plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.3
% Butterworth high-pass filter

clc; clear all; close all;
alphap = 50; % pass band attenuation in dB
alphas = 1; % stop band attenuation in dB
fp = 1050; % pass band frequency in Hz
fs = 600; % stop band frequency in Hz
fsam = 3500; % sampling frequency in Hz

wp = 2*fp/fsam;
ws = 2*fs/fsam;
[n,wn] = buttord(wp,ws,alphap,alphas); % minimal order, half- power frequency
[b,a] = butter(n,wn,'high'); % coefficients of the designed filter
[h,w] = freqz(b,a);
subplot(2,1,1),plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2),plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.4
% Butterworth band stop filter

clc; clear all; close all;
ws=[0.4 0.6]; % stop band frequency in radians
wp=[0.3 0.7]; % pass band frequency in radians
alphap=0.4; % pass band attenuation in dB
alphas=50; % stop band attenuation in dB

[n,wn] = buttord(wp,ws,alphap,alphas);
[b,a]=butter(n,wn,'stop');
[h,w] = freqz(b,a);
subplot(2,1,1);plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.5
% Chebyshev filter low-pass type-1

clc; clear all; close all;
alphap = 0.15; % pass band attenuation in dB
alphas = 0.9; % stop band attenuation in dB
wp = 0.3*pi; % pass band frequency in radians
ws = 0.5*pi; % stop band frequency in radians

[n,wn] = cheb1ord(wp/pi,ws/pi,alphap,alphas);
[b,a] = cheby1(n,alphap,wn); % coefficients of designed filter
[h,w] = freqz(b,a);
subplot(2,1,1);plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.6
% Chebyshev filter high-pass type-1

clc; clear all; close all;
alphap = 1; % pass band attenuation in dB
alphas = 15; % stop band attenuation in dB
wp = 0.3*pi; % pass band frequency in radians
ws = 0.2*pi; % stop band frequency in radians

[n,wn] = cheb1ord(wp/pi,ws/pi,alphap,alphas);
[b,a] = cheby1(n,alphap,wn,'high'); % coefficients of designed filter
[h,w] = freqz(b,a);
subplot(2,1,1),plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2), plot(w/pi, angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.7
% Chebyshev band pass filter type-1

clc; clear all; close all;
Wp = [60 200]/500;
Ws = [50 250]/500;
alphap = 3; % pass band attenuation in dB
alphas = 40; % stop band attenuation in dB

[n,Wp] = cheb1ord(Wp,Ws,alphap,alphas);
[b,a] = cheby1(n,alphap,Wp);
[h,w] = freqz(b,a);
subplot(2,1,1);plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.8
% Chebyshev low- pass filter type- 2

clc; clear all; close all;
Wp = 40/500; % pass band frequency in radians
Ws = 150/500; % stop band frequency in radians
alphap = 3; % pass band attenuation in dB
alphas = 40; % stop band attenuation in dB

[n,Ws] = cheb2ord(Wp,Ws,alphap,alphas);
[b,a] = cheby2(n,alphas,Ws);
[h,w] = freqz(b,a);
subplot(2,1,1);plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');

% Program 8.9
% Chebyshev band pass filter type-2

clc; clear all; close all;
Wp = [60 200]/500; % pass band frequency in radians
Ws = [50 250]/500; % stop band frequency in radians
alphap = 3; % pass band attenuation in dB
alphas = 40; % stop band attenuation in dB

[n,Ws] = cheb2ord(Wp,Ws,alphap,alphas);
[b,a] = cheby2(n,alphas,Ws);
[h,w] = freqz(b,a);
subplot(2,1,1);plot(w/pi,20*log10(abs(h)));
xlabel('Normalized Frequency');
ylabel('gain in db');
title('magnitude response');
subplot(2,1,2);plot(w/pi,angle(h));
xlabel('Normalized Frequency');
ylabel('phase in radians');
title('phase response');