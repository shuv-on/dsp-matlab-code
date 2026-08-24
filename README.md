# Digital Signal Processing (DSP) MATLAB Code Reference & Cheat Sheet

এই গাইডটিতে DSP-এর সমস্ত MATLAB প্রোগ্রামকে ৮টি প্রধান ক্যাটাগরিতে ভাগ করে তাদের মূল সূত্র, লজিক এবং কমান্ড সাজানো হয়েছে। প্রতিটি ক্যাটাগরিতে সংক্ষেপে মূল বিষয় ব্যাখ্যা করা হয়েছে এবং প্রয়োজনীয় উদাহরণ কোড দেওয়া হয়েছে।

---

## 📋 সূচিপত্র (Table of Contents)
1. [Category 1: Discrete Signals Generation (সংকেত তৈরি)](#1-discrete-signals-generation)
2. [Category 2: System Properties Check (সিস্টেমের বৈশিষ্ট্য পরীক্ষা)](#2-system-properties-check)
3. [Category 3: Convolution & Correlation (সংকেতের গুণন ও সম্পর্ক)](#3-convolution--correlation)
4. [Category 4: Z-Transform & Inverse Z-Transform (জেড-ট্রান্সফর্ম)](#4-z-transform--inverse-z-transform)
5. [Category 5: System Structure Realization & Conversion (ফিল্টার স্ট্রাকচার)](#5-system-structure-realization--conversion)
6. [Category 6: Fourier Series, DTFT & DFT Properties (ফুরিয়ার এনালাইসিস)](#6-fourier-series-dtft--dft-properties)
7. [Category 7: Fast Fourier Transform (FFT) & Applications (ফাস্ট ফুরিয়ার ট্রান্সফর্ম)](#7-fast-fourier-transform-fft--applications)
8. [Category 8: IIR Digital Filter Design (ডিজিটাল ফিল্টার ডিজাইন)](#8-iir-digital-filter-design)
9. [📌 Visualization & Plotting Cheat Sheet (কমন কমান্ডসমূহ)](#-visualization--plotting-cheat-sheet)

---

## 1. Discrete Signals Generation
মৌলিক এবং জটিল মৌলিক ডিসক্রিট সিগন্যাল তৈরির মূল ফর্মুলা।

### 🔹 Key Functions & Logic
- **Impulse Signal $\delta(n)$:** সংজ্ঞায়িত পয়েন্টে `1`, বাকি ক্ষেত্রে `0` $
ightarrow$ `[zeros(1, N), ones(1, 1), zeros(1, N)]`
- **Unit Step Signal $u(n)$:** $n \ge 0$-তে `1`, অন্যথায় `0` $
ightarrow$ `[zeros(1, N), ones(1, N+1)]`
- **Unit Ramp Signal $r(n)$:** $r(n) = n \cdot u(n)$ $
ightarrow$ `n = 0:10; ramp = n;`
- **Exponential Signal:** $x(n) = a^n$ $
ightarrow$ `x = a.^n;` (এলিমেন্ট-ওয়াইজ পাওয়ারের জন্য `.^` ব্যবহার বাধ্যতামূলক)
- **Sinusoidal Signal:** $x(n) = A \cos(2\pi f n + \phi)$ $
ightarrow$ `x = A*cos(2*pi*f*n);`

### 💡 Representative Example (Program 1.1 - 1.3 Combo)
```matlab
clc; clear all; close all;
n = -10:10;

% Impulse
impulse = [zeros(1,10), ones(1,1), zeros(1,10)];
subplot(2,2,1); stem(n, impulse); title('Unit Impulse');

% Step
step = [zeros(1,10), ones(1,11)];
subplot(2,2,2); stem(n, step); title('Unit Step');

% Exponential
a = 0.8; x_exp = a.^n;
subplot(2,2,3); stem(n, x_exp); title('Exponential x(n)=0.8^n');

% Signal Multiplication
f = 0.1; x_sin = cos(2*pi*f*n);
y = x_exp .* x_sin; % Element-wise multiplication
subplot(2,2,4); stem(n, y); title('x_exp * x_sin');
```

---

## 2. System Properties Check
সিস্টেমের টাইপ, স্টেবিলিটি এবং অন্যান্য গাণিতিক বৈশিষ্ট্য পরীক্ষার ফ্রেমওয়ার্ক।

### 🔹 Key Formulas & Logic
- **Even Component:** $x_e(n) = rac{x(n) + x(-n)}{2}$ $
ightarrow$ `xe = 0.5 * (x + fliplr(x))`
- **Odd Component:** $x_o(n) = rac{x(n) - x(-n)}{2}$ $
ightarrow$ `xo = 0.5 * (x - fliplr(x))`
- **Linearity Test:** Superposition 법칙 $T(a x_1 + b x_2) = a T(x_1) + b T(x_2)$
- **Time Invariance Test:** Input delay $D$ দিলে Output-এও ঠিক সমান delay হতে হবে $
ightarrow y_d(n) = y(n-D)$
- **BIBO Stability:** $\sum_{k=-\infty}^{\infty} |h(k)| < \infty$ $
ightarrow$ `sum(abs(h))` সীমাবদ্ধ মান হতে হবে।

### 💡 Representative Example (Program 1.9 Linearity Test)
```matlab
clc; clear all; close all;
n = 0:50; a = 2; b = -3;
x1 = cos(2*pi*0.1*n); x2 = cos(2*pi*0.4*n);
x_combined = a*x1 + b*x2;

num = [2.2403 2.4908 2.2403]; den = [1 -0.4 0.75]; ic = [0 0];

% Weighted Input Output
y = filter(num, den, x_combined, ic);

% Individual Weighted Outputs
y1 = filter(num, den, x1, ic);
y2 = filter(num, den, x2, ic);
yt = a*y1 + b*y2;

% Difference
diff = y - yt; % পার্থক্য ০ হলে সিস্টেমটি Linear
subplot(3,1,1); stem(n, y); title('Weighted Input Output y[n]');
subplot(3,1,2); stem(n, yt); title('Weighted Output Sum yt[n]');
subplot(3,1,3); stem(n, diff); title('Difference (Zero means Linear)');
```

---

## 3. Convolution & Correlation
টাইম ডোমেইনে কনভোলিউশন এবং সিগন্যালের মধ্যে মিল (Correlation) বের করার শর্টকাট।

### 🔹 Key Functions & Formulas
- **Linear Convolution:** $y(n) = x_1(n) * x_2(n)$ $
ightarrow$ `y = conv(x1, x2)`
- **Circular Convolution:** `y = cconv(x1, x2, N)`
- **Linear Convolution via Circular Convolution:** জিরো প্যাডিং (Zero-padding) এর মাধ্যমে length $N = L_1 + L_2 - 1$ করে `cconv` প্রয়োগ।
- **Autocorrelation:** $R_{xx}(k) = \sum x(n)x(n-k)$ $
ightarrow$ `y = xcorr(x1, x1)`

### 💡 Representative Example (Program 2.1 & 2.2)
```matlab
clc; clear all; close all;
x1 = [1 2 0 1]; x2 = [2 2 1 1];

% 1. Direct Linear Convolution
y_lin = conv(x1, x2);

% 2. Linear Convolution using Circular Convolution
N = length(x1) + length(x2) - 1;
x1_padded = [x1, zeros(1, length(x2)-1)];
x2_padded = [x2, zeros(1, length(x1)-1)];
y_circ_lin = cconv(x1_padded, x2_padded, N);

disp('Direct Linear Convolution Output:'); disp(y_lin);
disp('Circular Convolution based Output:'); disp(y_circ_lin);
```

---

## 4. Z-Transform & Inverse Z-Transform
S-Domain থেকে Z-Domain ট্র্যান্সফর্মেসন এবং সিস্টেম পোল-জিরো এনালাইসিস।

### 🔹 Key Functions & Logic
- **Symbolic Z-Transform:** `syms n z; b = ztrans(x);`
- **Inverse Z-Transform:** `c = iztrans(X);`
- **Partial Fraction Expansion (Residues):** $[r, p, k] = 	ext{residuez}(num, den)$
- **Polynomial Long Division:** $[h, r] = 	ext{deconv}(num, den)$
- **Pole-Zero Diagram:** `zplane(z, p)` অথবা `zplane(num, den)`

### 💡 Representative Example (Program 3.1 & 3.5)
```matlab
clc; clear all; close all;
% Symbolic Z-Transform
syms n wo
x1 = cos(wo*n);
X1 = ztrans(x1);
disp('Z-transform of cos(wo*n):'); disp(X1);

% Pole-Zero Plot using Butterworth filter coefficients
[z, p, k] = butter(5, 0.4);
figure; zplane(z, p);
title('Pole-Zero Plot of 5th Order Lowpass Butterworth Filter');
```

---

## 5. System Structure Realization & Conversion
ডিজিটাল ফিল্টারের বিভিন্ন স্ট্রাকচার (Direct Form, Cascade Form, Parallel Form) রূপান্তর।

### 🔹 Key Conversions
- **Direct Form $
ightarrow$ Parallel Form:** `[r, p, k] = residuez(num, den);`
- **Parallel Form $
ightarrow$ Direct Form:** `[b, a] = residuez(R, P, C);`
- **Direct Form $
ightarrow$ Cascade Form:**
  `roots(b)` ও `roots(a)` থেকে ২য় ঘাতের সাব-পলিনোমিয়াল তৈরি করতে `poly()` ব্যবহার করা হয়।
- **Cascaded Sub-filters Combination:**
  ১ম সাব-সিস্টেম $B_1(z), A_1(z)$ এবং ২য় সাব-সিস্টেম $B_2(z), A_2(z)$ হলে overall:
  `b = conv(B1, B2); a = conv(A1, A2);`

### 💡 Representative Example (Program 4.1 Parallel Form)
```matlab
clc; clear all; close all;
num = [2 10 23 34 31 16 4];
den = [36 78 87 59 26 7 1];

% Convert Direct Form to Parallel Form (Residue method)
[r, p, k] = residuez(num, den);

disp('Residues (r):'); disp(r);
disp('Poles (p):'); disp(p);
disp('Direct term (k):'); disp(k);
```

---

## 6. Fourier Series, DTFT & DFT Properties
ডিজিটাল সংকেতের ফ্রিকোয়েন্সি ডোমেইন এনালাইসিস।

### 🔹 Key Functions & Properties
- **Continuous Fourier Transform:** `syms t; F = fourier(f);`
- **DTFT Evaluation (Frequency Response):** $H(e^{j\omega})$ $
ightarrow$ `[h, w] = freqz(num, den, w_vec)`
- **Parseval's Energy Relation:** $\sum |x(n)|^2 = rac{1}{N} \sum |X(k)|^2$
  $
ightarrow$ `sum(x.^2) == sum(abs(X).^2) / N`
- **DFT Matrix Formulation:** `X = x * dftmtx(N);`

### 💡 Representative Example (Program 5.3 DTFT)
```matlab
clc; clear all; close all;
w = -pi:2*pi/255:pi;
num = [1 2]; den = [1 -0.2];

[h, w] = freqz(num, den, w);

subplot(2,1,1); plot(w/pi, abs(h));
xlabel('Normalized Frequency (	imes \pi rad/sample)'); ylabel('Magnitude');
title('DTFT Magnitude Spectrum');

subplot(2,1,2); plot(w/pi, angle(h));
xlabel('Normalized Frequency (	imes \pi rad/sample)'); ylabel('Phase (rad)');
title('DTFT Phase Spectrum');
```

---

## 7. Fast Fourier Transform (FFT) & Applications
DFT দ্রুত গণনার অ্যালগরিদম এবং এর প্রয়োগ।

### 🔹 Key Functions
- **N-Point FFT:** `X = fft(x, N)`
- **N-Point IFFT:** `x = ifft(X, N)`
- **FFT-based Linear Convolution:**
  ```matlab
  X = fft(x, L+M-1);
  H = fft(h, L+M-1);
  y = ifft(X .* H);
  ```
- **FFT-based Circular Convolution:**
  ```matlab
  X = fft(x, N);
  H = fft(h, N);
  y = real(ifft(X .* H));
  ```

### 💡 Representative Example (Program 7.1 FFT & IFFT)
```matlab
clc; clear all; close all;
x = [2 2 2 2 1 1 1 1];

% Compute 8-point FFT
X = fft(x);
magX = abs(X);
phaseX = angle(X);

% Compute Inverse FFT
x_rec = ifft(X);

subplot(2,1,1); stem(magX); title('FFT Magnitude Response');
subplot(2,1,2); stem(phaseX); title('FFT Phase Response');

disp('Reconstructed Signal (IFFT):'); disp(x_rec);
```

---

## 8. IIR Digital Filter Design
Butterworth এবং Chebyshev ডিজিটাল ফিল্টার ডিজাইনের সম্পূর্ণ গাইড।

### 🔹 Step-by-Step Design Steps
1. **Order ($n$) এবং Cutoff Frequency ($W_n$) বের করা:**
   - **Butterworth:** `[n, Wn] = buttord(Wp, Ws, Rp, Rs);`
   - **Chebyshev Type-1:** `[n, Wn] = cheb1ord(Wp, Ws, Rp, Rs);`
   - **Chebyshev Type-2:** `[n, Wn] = cheb2ord(Wp, Ws, Rp, Rs);`
2. **Filter Coefficients ($b, a$) তৈরি করা:**
   - **Lowpass:** `[b, a] = butter(n, Wn);` বা `cheby1(n, Rp, Wn);`
   - **Highpass:** `[b, a] = butter(n, Wn, 'high');`
   - **Bandpass:** `[b, a] = butter(n, Wn);` (এখানে $W_n = [W_1, W_2]$ দুই উপাদানের ভেক্টর)
   - **Bandstop:** `[b, a] = butter(n, Wn, 'stop');`
3. **Magnitude & Phase Response Plot করা:** `freqz(b, a)`

### 💡 Representative Example (Program 8.2 Butterworth Low-Pass Filter)
```matlab
clc; clear all; close all;
alphap = 0.5; % Passband ripple (dB)
alphas = 30;  % Stopband attenuation (dB)
fpass = 1000; % Passband cutoff (Hz)
fstop = 1500; % Stopband cutoff (Hz)
fsam = 5000;  % Sampling frequency (Hz)

% Normalized Frequencies (0 to 1, where 1 is Nyquist freq fsam/2)
wp = 2 * fpass / fsam;
ws = 2 * fstop / fsam;

% 1. Find Order & Cutoff
[n, wn] = buttord(wp, ws, alphap, alphas);

% 2. Design Filter Coefficients
[b, a] = butter(n, wn);

% 3. Plot Frequency Response
[h, w] = freqz(b, a, 512);

subplot(2,1,1); plot(w/pi, 20*log10(abs(h)));
grid on; xlabel('Normalized Frequency (	imes\pi rad/sample)');
ylabel('Gain (dB)'); title('Butterworth LPF Magnitude Response');

subplot(2,1,2); plot(w/pi, angle(h));
grid on; xlabel('Normalized Frequency (	imes\pi rad/sample)');
ylabel('Phase (radians)'); title('Phase Response');
```

---

## 📌 Visualization & Plotting Cheat Sheet
একটি উইন্ডোতে সুন্দরভাবে ভিজ্যুয়ালাইজ করার কমন কমান্ডসমূহ:

| ম্যাটল্যাব কমান্ড | কাজের বিবরণ |
| :--- | :--- |
| `stem(n, x)` | Discrete signals বা সংকেতের বিন্দু নির্দেশক প্লট |
| `plot(x, y)` | Continuous signals বা মসৃণ রেখাচিত্রের জন্য |
| `subplot(row, col, index)` | একটি চিত্র উইন্ডোকে কয়েকটি ভাগে ভাগ করে আলাদা প্লট করা |
| `20*log10(abs(h))` | লিনিয়ার Gain-কে Decibel (dB) এককে পরিবর্তন করা |
| `angle(h)` | Phase response (রেডিয়ানে) নির্দেশ করা |
| `xlabel('...'), ylabel('...')` | অক্ষের নাম বা টাইটেল দেওয়া |
| `title('...')` | নির্দিষ্ট সাবপ্লটের নাম প্রদান |
| `grid on` | প্লটের পেছনে গ্রিড লাইন চালু করা |
| `clc; clear all; close all;` | স্ক্রিন, মেমোরি ফ্রিকোয়েন্সি এবং পূর্বের চিত্রগুলো পরিষ্কার করে নতুন কোড রান করা |

---