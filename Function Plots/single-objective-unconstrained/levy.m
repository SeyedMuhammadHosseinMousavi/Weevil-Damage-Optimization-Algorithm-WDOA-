function varargout = levy(X)

% if no input is given, return dimensions, bounds and minimum
if (nargin == 0)
varargout{1} = 2;  % # dims
varargout{2} = [-10, -10]; % LB
varargout{3} = [+10, +10]; % UB
varargout{4} = [1, 3]; % solution
varargout{5} = 0; % function value at solution

% otherwise, output function value
else

d = length(X);

for ii = 1:d
w(ii) = 1 + (X(ii) - 1)/4;
end

term1 = (sin(pi*w(1)))^2;
term3 = (w(d)-1)^2 * (1+(sin(2*pi*w(d)))^2);

sum = 0;
for ii = 1:(d-1)
wi = w(ii);
new = (wi-1)^2 * (1+10*(sin(pi*wi+1))^2);
sum = sum + new;
end

varargout{1} = term1 + sum + term3;

end
