function [y, SNR_impr] = myAveraging_Coh(x,Nsamp)
    N = length(x)
    period = Nsamp;            %number of samples in one period of the signal
    Nset = ceil(N/period)      %number of sets
    %add = floor(period-rem(N,period))
    %x = [x zeros(1,add)].';                  
    xset = reshape(x,[period,Nset]);
    for i=1:period
        y(i) = sum(xset(i,:))/sum((xset(i,:)~=0));
    end
    y = y.';
    x = x(1:period);
    N = length(x);
    xfreq = (abs(fft(x))*2/N).^2;
    xfreq = xfreq(1:floor(N/2));  
    yf = (abs(fft(y))*2/period).^2;
    yf = yf(1:floor(period/2));
   treshold = 0.01;
    xs = xfreq.*(xfreq>treshold*max(xfreq));
    xn = xfreq.*(xfreq<treshold*max(xfreq));
    SNRx = 10*log10(sum(xs)/sum(xn));
    ys = yf.*(yf>treshold*max(yf));
    yn = yf.*(yf<treshold*max(yf));
    SNRy = 10*log10(sum(ys)/sum(yn));
%}
%{    
    figure
    stem(xs)
    
    figure
    stem(ys)
    
    figure
    stem(xn)
    
    figure
    stem(yn)
%}
    SNR_impr.theor = 10*log10(Nset);
    SNR_impr.fact = SNRy-SNRx;
end
%}
%my
%{
function [y, SNR_impr] = myAveraging_Coh(x,N)
    SNR_impr.theor=10*log10(length(x))
    snrprev=mySNR(x)
    N=length(x)
    x=reshape(x,[23,23])
    x=x.';
    x=sum(x)
    for n=1:N
        x(N/N+n)=x(n);
    end
    SNR_impr.fact=mySNR(x)-snrprev;
    y=x;
    end
%}