% function y = mySignalDetection(x)
% y=abs(hilbert(x));
% y=y-mean(y);
% end
function [mag, ph,freq_demod] = mySignalDetection(x, fc, t)
    z = hilbert(x);             %analytic signal
    y = z.*exp(-1i*2*pi*fc*t);  %complex envelope
    mag = abs(y);
    y(mag<1e-3)=0;
    ph = angle(y);
    freq_demod=diff(ph)./diff(t);
end
%{
function [mag,ph] = mySignalDetection(x,fc,fs)
t=(0:(length(x)-1)).'/fs;
analytical_signal=x+1j*hilbert(x);
complex_envelope=analytical_signal.*(exp(-1j*2*pi*fc*t));
information_signal=abs(complex_envelope);
size(information_signal);
information_signal(2:size(information_signal,1),:)=[];
size(information_signal);
mag=information_signal-mean(information_signal);

end
%}