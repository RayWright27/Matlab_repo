%Carrier: 450 MHz; 1st mod. freq.: 36 MHz; 2nd mod. freq.: 38 MHz
%Modulation: FM; Sampling: Band-pass; Leakage: Yes, Blackman window; Spectrum: DFT; Averaging: Coherent
clear all; clc;
%% Step 1: signal sampling
f_mod1=36e6;
f_mod2=38e6;
fc=450e6;
modindx=0.5%modulation index
freqdev=10e6%frequency deviation
[fs,T,N] = DefineParams_bandpas([f_mod1 f_mod2])
t = [0:N-1]'/fs; 
%% Step 2: signal modulation
signals=modindx*(sin(2*pi*f_mod1.*t)+sin(2*pi*f_mod2.*t));
%signal=sin(2.*pi.*fc.*t+sin(2*pi*f_mod1.*t)+sin(2*pi*f_mod2.*t));
tiledlayout(3,5)
f = (0:(length(signals)-1))*fs;N;
y=abs(mydft(signals)*2/N);
nexttile
stem(f,y);      
xlabel 'frequency (Hz)'
ylabel 'modulating signals'
grid 
[fs,T,N] = DefineParams_bandpass([fc f_mod1 f_mod2],freqdev)
t = [0:N-1]'/fs; 
signals=modindx*(sin(2*pi*f_mod1.*t)+sin(2*pi*f_mod2.*t));
signal=fmmod(signals,fc,fs,freqdev)
nexttile
plot(t, signal)%,freqmod1,t,freqmod2)
xlabel 'time(s)'
ylabel 'time domain'
grid
%nexttile
f = (0:(length(signal)-1))*fs/N;
y=abs(mydft(signal)*2/N);
nexttile
stem(f,y);      
xlabel 'frequency (Hz)'
ylabel 'modulated signal'
grid 
%% Step 3: adding leakage and windowing
N=round(N*2.23);%2.22
t = [0:N-1]'/fs;
signals=modindx*(sin(2*pi*f_mod1.*t)+sin(2*pi*f_mod2.*t));   
signal=fmmod(signals,fc,fs,freqdev);
nexttile
plot(t,signal)
xlabel 'time(s)'
ylabel 'signal with leakage'
grid 
f = (0:(length(signal)-1))*fs/N;
y=abs(mydft(signal)*2/N);
nexttile
stem(f,y);
xlabel 'frequency (Hz)'
ylabel 'modulated signal w/leakage'
grid 
signal_windowed=signal.*blackman(length(signal));
nexttile
plot (t,signal_windowed)
xlabel 'time(s)'
ylabel 'windowed signal'
grid   
%% Step 4 adding noise
[signal_windowed_wnoise]=mySignal(signal_windowed,1e-3);
nexttile
plot (t,signal_windowed_wnoise)
xlabel 'time(s)'
ylabel 'windowed, noisy and modulated signal'
grid
%% Step 5 averaging
Nsamp =N/2;%/2;
[signal_avraged,SNR_impr]=myAveraging_Coh(signal_windowed_wnoise,Nsamp);
nexttile
t = [0:length(signal_avraged)-1]'/fs; %new time axis
plot(t,signal_avraged)
xlabel 'time(s)'
ylabel 'averaged signal'
grid 
f = (0:(length(signal_avraged)-1))*fs/N;
y=abs(mydft(signal_avraged)*2/N);
nexttile
stem(f,y);
xlabel 'frequency (Hz)'
ylabel 'averaged signal'
grid
%% Step 6 signal detection
t_new = t(1:length(signal_avraged));% new time axis for signal detection
[mag,phase,freq_demod]=mySignalDetection(signal_avraged,fc,t_new);
N=length(freq_demod)
t=0:1/fs:N/fs-1/fs; % new t axis for envelope
nexttile
plot(t,freq_demod)    
xlabel 'time(s)'
ylabel 'envelope'
grid     
%spectrum and phase plot
t=(0:(N-1)).'/fs;
f = (0:(length(freq_demod)-1))*fs/N;
y=mydft(freq_demod);
y(abs(y)<(max(abs(y)))*1e-1) = 0;
theta = angle(y); 
amplitude=abs(mydft(freq_demod)*2/N);
max_of_amplitude=max(amplitude)
amplitude=amplitude./max(amplitude);
amplitude(abs(amplitude)<max(abs(amplitude))*1e-1) = 0;
    nexttile
      stem(f,amplitude);      
xlabel 'Frequency (Hz)'
ylabel 'Ampl'
grid         
    nexttile
       stem(f,theta);
      
xlabel 'Frequency (Hz)'
ylabel 'Phase ,rad'
grid
%}
%}