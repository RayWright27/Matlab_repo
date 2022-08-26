function [fs, T, N] = DefineParams_bandpass(f,freqdev) %second version
    fc = f(1);
    fb =2*(freqdev+max([f(2) f(3)]));%according to Karson's bandwidth rule   %1.5*f(2); зач
    m = floor(fc/fb - 0.5);
    fs = 7*(2*fc+fb)/(m+1);
    fl = [fs, fb/2];
    e=0;
    while any(mod(fl,1))~=0
        fl = 10*fl;
        e = e+1;
    end
    T = (10^e)/gcd(fl(1), fl(2));
    N = T*fs;
end






