function [val] = mySNR(x)
   X =abs(fft(x)*2/length(x));
   n=floor(numel(x)/2)
   X = X(1:n);
   threshold=max(X)*1e-3
   signal_fft=X.*(X>threshold.*max(X));
   noise_fft=X.*(X<threshold.*max(X));
   val = 10 * log10(sum(signal_fft.^2)./sum(noise_fft.^2));
end