function [y, SNR_impr] = myAveraging_Exp(x, alpha)
    y = x;
    for i=2:length(y)
        y(i) = alpha*x(i)+(1-alpha)*y(i-1);
    end
    y=y.';
%     N = length(x);
% 
%     xf = (abs(fft(x))*2/N).^2;
%     xf = xf(1:floor(N/2));
%     
%     yf = (abs(fft(y))*2/N).^2;
%     yf = yf(1:floor(N/2));
% 
%     treshold = 1e-6;
%     xs = xf.*(xf>treshold*max(xf));
%     xn = xf.*(xf<treshold*max(xf));
%     SNRx = 10*log10(sum(xs)/sum(xn));
%     
%     ys = yf.*(yf>treshold*max(yf));
%     yn = yf.*(yf<treshold*max(yf));
%     SNRy = 10*log10(sum(ys)/sum(yn));  
    SNR_impr.theor = 10*log10((2-alpha)/alpha);
    SNR_impr.fact = mySNR(y)-mySNR(x);
end