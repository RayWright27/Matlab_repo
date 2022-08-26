function [fs, T, N] = DefineParams_lowpass(f)
fs=3*max(f)
power=0
while any(mod(f,1))~=0
    f=10*f
    power=power+1
end
GCD=f(1)
for i=1:(length(f))
    GCD=gcd(GCD,f(i))
end
T=10^power/GCD
N=fs*T
end