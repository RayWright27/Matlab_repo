function [y] = mySignal(x, rms_val)
   noise = rms_val*randn(length(x));
   noise=x+rms_val.x;
   for i=1:length(x)
   y(i)= x(i)+noise(i);
   end
end