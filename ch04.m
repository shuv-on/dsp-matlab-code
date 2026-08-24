% Program 4.1
% Parallel form realization of IIR filters

clc; clear all; close all;
num=[2 10 23 34 31 16 4];
den=[36 78 87 59 26 7 1];
[r1 p1 k1]=residuez(num,den);
[r2 p2 k2]=residuez(num,den);
disp('parallel form 1');
disp('residues are');
disp(r1);
disp('poles are at');
disp(p1);
disp('constant value');
disp(k1);
disp('parallel form II');
disp('residues are');
disp(r2);
disp('poles are at');
disp(p2);
disp('constant value');
disp(k2);

% Program 4.2
% Direct form to cascade form conversion

clc; clear all; close all;
b=[4 5 6]; %numerator coefficients of direct form
a=[1 2 3]; %denominator coefficients of direct form

% compute gain coefficient
b0=b(1);
a0=a(1);
b=b/b0;
a=a/a0;

m=length(b);
n=length(a);

if n > m
    b= [b zeros(1,n-m)];
elseif m > n
    a= [a zeros(1,m-n)];
end

k = floor(n/2);
B = zeros(k,3);
A = zeros(k,3);

if k*2 == n
    b = [b 0];
    a = [a 0];
end

broots = cplxpair(roots(b));
aroots = cplxpair(roots(a));

for i = 1:2:2*k
    brow = broots(i:1:i+1,:);
    brow = real(poly(brow));
    B(fix((i+1)/2),:)=brow;
    arow = aroots(i:1:i+1,:);
    arow = real(poly(arow));
    A(fix((i+1)/2),:)=arow;
end

disp('numerator coefficients of cascade form');
disp(B);
disp('denominator coefficients of cascade form');
disp(A);

% Program 4.3
% Cascade form realization of FIR & IIR filters

clc; clear all; close all;
b=[4 5 6]; %numerator coefficients of direct form
a=[1 2 3]; %denominator coefficients of direct form

% compute gain coefficient
b0=b(1);
x=[1 2 3 8 9 6 4 7 1 0];% input sequence

[k l]=size(b);
n=length(x);
w=zeros(k+1,n);
w(1,:)=x;

for i=1:1:k
    w(i+1,:)=filter(b(i,:),a(i,:),w(i,:));
end

y=b0*w(k+1,:);
disp('output of the final filter operation');
disp(y);

% Program 4.4
% Cascade form to direct form conversion

clc; clear all; close all;
B=[4 5 6]; %numerator coefficients of cascade form
A=[1 2 3]; %denominator coefficients of cascade form

% compute gain coefficient
b0=B(1);
[k l]=size(B);
b=[1];
a=[1];

for i=1:1:k
    b=conv(b,B(i,:));
    a=conv(a,A(i,:));
end

b=b*b0;
disp('numerator coefficients of direct form');
disp(b);
disp('denominator coefficients of direct form');
disp(a);

% Program 4.5
% Direct form to parallel form conversion

clc; clear all; close all;
b=[4 5 6]; %numerator coefficients of direct form
a=[1 2 3]; %denominator coefficients of direct form

m=length(b);
n=length(a);
[r1 p1 c]=residuez(b,a);
p=cplxpair(p1,10000000*eps);
p2=cplxpair(p1);

I=[];
for j=1:1:length(p2)
    for i=1:1:length(p1)
        if(abs(p1(i)-p2(j)) < 0.0001)
            I=[I,i];
        end
    end
end

I=I';
r=r1(I);
K=floor(n/2);
B=zeros(K,2);
A=zeros(K,3);

if K*2 == n
    for i=1:2:n-2
        Brow=r(i:1:i+1,:);
        Arow=p(i:1:i+1,:);
        [Brow Arow]=residuez(Brow,Arow,[]);
        B(fix((i+1)/2),:)=real(Brow);
        A(fix((i+1)/2),:)=real(Arow);
    end
    [Brow Arow]=residuez(r(n-1),p(n-1),[]);
    B(K,:)=[real(Brow) 0];
    A(K,:)=[real(Arow) 0];
else
    for i=1:2:n-1
        Brow=r(i:1:i+1,:);
        Arow=p(i:1:i+1,:);
        [Brow Arow]=residuez(Brow,Arow,[]);
        B(fix((i+1)/2),:)=real(Brow);
        A(fix((i+1)/2),:)=real(Arow);
    end
end

disp('numerator coefficients of parallel form');
disp(B);
disp('denominator coefficients of parallel form');
disp(A);

% Program 4.6
% Parallel form to direct form conversion

clc; clear all; close all;
C = [0];
A = [1 1 0.9;1 0.4 -0.4];
B = [2 4;3 1];

[K,L]=size(A);
R = [];
P = [];

for i=1:1:K
    [r p k]=residuez(B(i,:),A(i,:));
    R = [R;r];
    P = [P;p];
end

[b a]=residuez(R,P,C);
b = b(:);
a = a(:);

disp('numerator coefficients of direct form');
disp(b);
disp('denominator coefficients of direct form');
disp(a);