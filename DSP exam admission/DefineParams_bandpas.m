function [fs, T, N] = DefineParams_bandpass(f) %second version
    fc = (max(f)+min(f))/2;%f(1);
    fb =1.5*f(2); %1.5*f(2);
    m = floor(fc/fb - 0.5);
    fs = 8*(2*fc+fb)/(m+1);%10*(2*fc+fb)/(m+1);
    fl = [fs, fb/2];
    e=0;
    while any(mod(fl,1))~=0
        fl = 10*fl;
        e = e+1;
    end
    T = (10^e)/gcd(fl(1), fl(2));
    N = T*fs;
end