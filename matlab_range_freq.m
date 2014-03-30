% demo program untuk memfilter suara pada range fekuensi oktaf tertentu
% by bagustris bagustris@linuxmail.org
% adopted from somewhere (forget aka lupa)

% set general variables
clear all; close all; clc;
sf = 22050;  % sample frequency
nf = sf / 2; % nyquist frequency
d = 1.0;     % duration, ganti untuk merubah durasi suara
n = sf * d;  % number of samples
nh = n / 2;  % half number of samples

% set variables for filter
lf = 1000;   % lowest frequency, ganti dengan batas bawah bandpass
hf = 4000;   % highest frequency, ganti dengan batas atas bandpass
lp = lf * d; % ls point in frequency domain
hp = hf * d; % hf point in frequency domain

% band pass filter!
filter = zeros(1, n);           % initializaiton by 0
filter(1, lp : hp) = 1;         % filter design in real number
filter(1, n - hp : n - lp) = 1; % filter design in imaginary number

% make noise
rand('state',sum(100 * clock));  % initialize random seed
noise = randn(1, n);             % Gausian noise
noise = noise / max(abs(noise)); % -1 to 1 normalization

% do filter
s = fft(noise);                  % FFT
s = s .* filter;                 % filtering
s = ifft(s);                     % inverse FFT
s = real(s);

%untuk mendengarkan suara asli
sound(noise,sf);
pause(d+0.5);

%untuk mendengarkan suara terfilter (bandpass);
sound(s,sf);
pause(d+0.5);

%untuk  menyimpan file suara dalam format .wav
%ketik perintah berikut dalam command window (tanpa tanda persen%)
% wavwrite(s,sf 'namafile.wav');
