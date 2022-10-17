function [y] = Levy(xx)
d = length(xx);
for ii = 1:d
w(ii) = 1 + (xx(ii) - 1)/4;
end
term1 = (sin(pi*w(1)))^2;
term3 = (w(d)-1)^2 * (1+(sin(2*pi*w(d)))^2);
sum = 0;
for ii = 1:(d-1)
wi = w(ii);
new = (wi-1)^2 * (1+10*(sin(pi*wi+1))^2);
sum = sum + new;
end
y = term1 + sum + term3;
end
